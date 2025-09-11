class SimplexSolver {
  late List<List<double>> tableau;
  late List<int> basicVariables;
  late int numOriginalVariables;
  late int numTotalVariables;
  late int numConstraints;
  late bool isMaximization;
  SimplexResult? result;
  SimplexSolver();

  SimplexResult solve({
    required List<double> objectiveCoefficients,
    required List<List<double>> constraintMatrix,
    required List<double> rightHandSide,
    bool isMaximization = true,
  }) {
    try {
      _initializeProblem(
        objectiveCoefficients,
        constraintMatrix,
        rightHandSide,
        isMaximization,
      );

      _createInitialTableau(
        objectiveCoefficients,
        constraintMatrix,
        rightHandSide,
      );

      _applySimplex();

      result = _extractSolution();

      return result!;
    } catch (e) {
      return SimplexResult(
        isOptimal: false,
        isUnbounded: false,
        isInfeasible: true,
        error: e.toString(),
      );
    }
  }

  void _initializeProblem(
    List<double> objectiveCoefficients,
    List<List<double>> constraintMatrix,
    List<double> rightHandSide,
    bool maximization,
  ) {
    numOriginalVariables = objectiveCoefficients.length;
    numConstraints = constraintMatrix.length;
    isMaximization = maximization;

    for (int i = 0; i < numConstraints; i++) {
      if (rightHandSide[i] < 0) {
        throw Exception('Todas las restricciones deben tener b ≥ 0');
      }
    }

    numTotalVariables = numOriginalVariables + numConstraints;

    basicVariables = List.generate(
      numConstraints,
      (index) => numOriginalVariables + index,
    );
  }

  void _createInitialTableau(
    List<double> objectiveCoefficients,
    List<List<double>> constraintMatrix,
    List<double> rightHandSide,
  ) {
    int rows = numConstraints + 1;
    int cols = numTotalVariables + 1;

    tableau = List.generate(rows, (i) => List.filled(cols, 0.0));

    for (int i = 0; i < numConstraints; i++) {
      for (int j = 0; j < numOriginalVariables; j++) {
        tableau[i][j] = constraintMatrix[i][j];
      }

      tableau[i][numOriginalVariables + i] = 1.0;
      tableau[i][numTotalVariables] = rightHandSide[i];
    }

    for (int j = 0; j < numOriginalVariables; j++) {
      tableau[numConstraints][j] =
          isMaximization ? -objectiveCoefficients[j] : objectiveCoefficients[j];
    }

    for (int j = numOriginalVariables; j < numTotalVariables; j++) {
      tableau[numConstraints][j] = 0.0;
    }

    tableau[numConstraints][numTotalVariables] = 0.0;
  }

  void _applySimplex() {
    int maxIterations = 1000;
    int iteration = 0;

    while (iteration < maxIterations) {
      if (_isOptimal()) {
        break;
      }

      if (_isUnbounded()) {
        throw Exception('El problema es no acotado');
      }

      _performSimplexIteration();

      iteration++;
    }

    if (iteration >= maxIterations) {
      throw Exception('Numero maximo de iteraciones alcanzado');
    }
  }

  bool _isOptimal() {
    int zRow = numConstraints;

    for (int j = 0; j < numTotalVariables; j++) {
      if (isMaximization) {
        if (tableau[zRow][j] < -1e-10) {
          return false;
        }
      } else {
        if (tableau[zRow][j] > 1e-10) {
          return false;
        }
      }
    }
    return true;
  }

  bool _isUnbounded() {
    int enteringVariable = _findEnteringVariable();
    if (enteringVariable == -1) return false;
    for (int i = 0; i < numConstraints; i++) {
      if (tableau[i][enteringVariable] > 1e-10) {
        return false;
      }
    }
    return true;
  }

  void _performSimplexIteration() {
    int enteringVariable = _findEnteringVariable();
    if (enteringVariable == -1) {
      throw Exception('No se pudo encontrar variable entrante');
    }

    int leavingVariable = _findLeavingVariable(enteringVariable);
    if (leavingVariable == -1) {
      throw Exception('El problema es no acotado');
    }

    _pivot(leavingVariable, enteringVariable);
    basicVariables[leavingVariable] = enteringVariable;
  }

  int _findEnteringVariable() {
    int zRow = numConstraints;
    int enteringVariable = -1;
    double bestValue = 0.0;

    for (int j = 0; j < numTotalVariables; j++) {
      double value = tableau[zRow][j];

      if (isMaximization) {
        if (value < bestValue - 1e-10) {
          bestValue = value;
          enteringVariable = j;
        }
      } else {
        if (value > bestValue + 1e-10) {
          bestValue = value;
          enteringVariable = j;
        }
      }
    }

    return enteringVariable;
  }

  int _findLeavingVariable(int enteringVariable) {
    int leavingRow = -1;
    double minRatio = double.infinity;

    for (int i = 0; i < numConstraints; i++) {
      double pivot = tableau[i][enteringVariable];

      if (pivot > 1e-10) {
        double ratio = tableau[i][numTotalVariables] / pivot;

        if (ratio < minRatio - 1e-10) {
          minRatio = ratio;
          leavingRow = i;
        }
      }
    }

    return leavingRow;
  }

  void _pivot(int pivotRow, int pivotCol) {
    double pivotElement = tableau[pivotRow][pivotCol];

    if (pivotElement.abs() < 1e-10) {
      throw Exception('Elemento pivote es cero');
    }

    for (int j = 0; j <= numTotalVariables; j++) {
      tableau[pivotRow][j] /= pivotElement;
    }

    for (int i = 0; i <= numConstraints; i++) {
      if (i != pivotRow) {
        double multiplier = tableau[i][pivotCol];

        for (int j = 0; j <= numTotalVariables; j++) {
          tableau[i][j] -= multiplier * tableau[pivotRow][j];
        }
      }
    }
  }

  SimplexResult _extractSolution() {
    List<double> solution = List.filled(numOriginalVariables, 0.0);

    for (int i = 0; i < numConstraints; i++) {
      int basicVar = basicVariables[i];

      if (basicVar < numOriginalVariables) {
        solution[basicVar] = tableau[i][numTotalVariables];
      }
    }

    double objectiveValue = tableau[numConstraints][numTotalVariables];

    if (isMaximization) {
      objectiveValue = -objectiveValue;
    }

    return SimplexResult(
      isOptimal: true,
      isUnbounded: false,
      isInfeasible: false,
      solution: solution,
      objectiveValue: objectiveValue,
      basicVariables: List.from(basicVariables),
      tableau: tableau.map((row) => List<double>.from(row)).toList(),
    );
  }

  void printTableau() {
    print('\nTABLA');
    print('Variables basicas: $basicVariables');

    String header = 'Base\t';
    for (int j = 0; j < numTotalVariables; j++) {
      header += 'x${j + 1}\t';
    }
    header += 'RHS';
    print(header);

    for (int i = 0; i < numConstraints; i++) {
      String row = 'x${basicVariables[i] + 1}\t';
      for (int j = 0; j <= numTotalVariables; j++) {
        row += '${tableau[i][j].toStringAsFixed(2)}\t';
      }
      print(row);
    }

    String zRow = 'Z\t';
    for (int j = 0; j <= numTotalVariables; j++) {
      zRow += '${tableau[numConstraints][j].toStringAsFixed(2)}\t';
    }
    print(zRow);
    print('-------------------\n');
  }
}

class SimplexResult {
  final bool isOptimal;
  final bool isUnbounded;
  final bool isInfeasible;
  final List<double>? solution;
  final double? objectiveValue;
  final List<int>? basicVariables;
  final List<List<double>>? tableau;
  final String? error;

  SimplexResult({
    required this.isOptimal,
    required this.isUnbounded,
    required this.isInfeasible,
    this.solution,
    this.objectiveValue,
    this.basicVariables,
    this.tableau,
    this.error,
  });

  @override
  String toString() {
    if (isInfeasible) {
      return 'Problema infactible: ${error ?? "No hay solucion factible"}';
    }

    if (isUnbounded) {
      return 'Problema no acotado: La funcion objetivo puede crecer indefinidamente';
    }

    if (isOptimal && solution != null) {
      String solutionStr = '';
      for (int i = 0; i < solution!.length; i++) {
        solutionStr += 'x${i + 1} = ${solution![i].toStringAsFixed(4)}\n';
      }

      return '''
Solucion optima encontrada:
$solutionStr
Valor optimo de la funcion objetivo: ${objectiveValue!.toStringAsFixed(4)}
Variables basicas: ${basicVariables?.map((v) => 'x${v + 1}').join(', ')}
''';
    }

    return 'Error: ${error ?? "Resultado desconocido"}';
  }
}

class SimplexExample {
  static SimplexResult runExample1() {
    SimplexSolver solver = SimplexSolver();

    return solver.solve(
      objectiveCoefficients: [3.0, 2.0],
      constraintMatrix: [
        [1.0, 1.0],
        [2.0, 1.0],
      ],
      rightHandSide: [4.0, 6.0],
      isMaximization: true,
    );
  }

  static SimplexResult runExample2() {
    SimplexSolver solver = SimplexSolver();

    return solver.solve(
      objectiveCoefficients: [2.0, 3.0],
      constraintMatrix: [
        [-1.0, -2.0],
        [-2.0, -1.0],
      ],
      rightHandSide: [-6.0, -8.0],
      isMaximization: false,
    );
  }
}
