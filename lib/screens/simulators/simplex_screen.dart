import 'package:flutter/material.dart';
import 'package:simulador_decisiones/logic/simplex.dart';

class SimplexScreen extends StatefulWidget {
  const SimplexScreen({super.key});

  @override
  State<SimplexScreen> createState() => _SimplexScreenState();
}

class _SimplexScreenState extends State<SimplexScreen> {
  final TextEditingController _numVariablesController =
      TextEditingController(text: '2');
  final TextEditingController _numConstraintsController =
      TextEditingController(text: '2');

  int numVariables = 2;
  int numConstraints = 2;
  bool isMaximization = true;

  List<TextEditingController> objectiveControllers = [];

  List<List<TextEditingController>> constraintControllers = [];
  List<TextEditingController> rhsControllers = [];

  SimplexResult? result;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _initializeControllers() {
    _disposeControllers();

    objectiveControllers = List.generate(numVariables,
        (index) => TextEditingController(text: index == 0 ? '3' : '2'));

    constraintControllers = List.generate(
        numConstraints,
        (i) => List.generate(
            numVariables,
            (j) => TextEditingController(
                text: i == 0 ? (j == 0 ? '1' : '1') : (j == 0 ? '2' : '1'))));

    rhsControllers = List.generate(numConstraints,
        (index) => TextEditingController(text: index == 0 ? '4' : '6'));
  }

  void _disposeControllers() {
    for (var controller in objectiveControllers) {
      controller.dispose();
    }

    for (var row in constraintControllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }

    for (var controller in rhsControllers) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProblemSetup(),
            const SizedBox(height: 20),
            _buildObjectiveFunction(),
            const SizedBox(height: 20),
            _buildConstraints(),
            const SizedBox(height: 20),
            _buildSolveButton(),
            const SizedBox(height: 20),
            if (result != null) _buildResults(),
          ],
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: const Text("Simulador Método Simplex",
          style: TextStyle(color: Colors.white)),
      leading: const BackButton(color: Colors.white),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildProblemSetup() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configuración del Problema',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _numVariablesController,
                    decoration: const InputDecoration(
                      labelText: 'Número de Variables',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      int? newValue = int.tryParse(value);
                      if (newValue != null && newValue > 0 && newValue <= 10) {
                        setState(() {
                          numVariables = newValue;
                          _initializeControllers();
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _numConstraintsController,
                    decoration: const InputDecoration(
                      labelText: 'Número de Restricciones',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      int? newValue = int.tryParse(value);
                      if (newValue != null && newValue > 0 && newValue <= 10) {
                        setState(() {
                          numConstraints = newValue;
                          _initializeControllers();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Tipo de optimización: '),
                Radio<bool>(
                  value: true,
                  groupValue: isMaximization,
                  onChanged: (bool? value) {
                    setState(() {
                      isMaximization = value!;
                    });
                  },
                ),
                const Text('Maximizar'),
                Radio<bool>(
                  value: false,
                  groupValue: isMaximization,
                  onChanged: (bool? value) {
                    setState(() {
                      isMaximization = value!;
                    });
                  },
                ),
                const Text('Minimizar'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildObjectiveFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Función Objetivo: ${isMaximization ? "Maximizar" : "Minimizar"} Z',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Z = '),
                for (int i = 0; i < numVariables; i++) ...[
                  if (i > 0) const Text(' + '),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      controller: objectiveControllers[i],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text('x${i + 1}'),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConstraints() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Restricciones (formato: ax₁ + bx₂ + ... ≤ c)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            for (int i = 0; i < numConstraints; i++) ...[
              Row(
                children: [
                  for (int j = 0; j < numVariables; j++) ...[
                    if (j > 0) const Text(' + '),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        controller: constraintControllers[i][j],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text('x${j + 1}'),
                  ],
                  const Text(' ≤ '),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      controller: rhsControllers[i],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              if (i < numConstraints - 1) const SizedBox(height: 8),
            ],
            const SizedBox(height: 16),
            const Text(
              'Nota: Todas las variables son no negativas (x₁, x₂, ... ≥ 0)',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSolveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: isLoading ? null : _solveProblem,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        child: isLoading
            ? const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('Resolviendo...'),
                ],
              )
            : const Text(
                'Resolver Problema',
                style: TextStyle(fontSize: 16),
              ),
      ),
    );
  }

  Widget _buildResults() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resultado',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (result!.isOptimal) ...[
              const Text(
                '✅ Solución Óptima Encontrada',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Valor óptimo: ${result!.objectiveValue!.toStringAsFixed(4)}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Variables:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              for (int i = 0; i < result!.solution!.length; i++)
                Text('x${i + 1} = ${result!.solution![i].toStringAsFixed(4)}'),
              const SizedBox(height: 12),
              if (result!.basicVariables != null) ...[
                const Text(
                  'Variables básicas:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    result!.basicVariables!.map((v) => 'x${v + 1}').join(', ')),
              ],
            ] else if (result!.isUnbounded) ...[
              const Text(
                '⚠️ Problema No Acotado',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              const Text('La función objetivo puede crecer indefinidamente.'),
            ] else if (result!.isInfeasible) ...[
              const Text(
                '❌ Problema Infactible',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                  'No existe solución que satisfaga todas las restricciones.'),
              if (result!.error != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Error: ${result!.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _loadExampleProblem,
                  child: const Text('Cargar Ejemplo'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _clearProblem,
                  child: const Text('Limpiar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _solveProblem() async {
    setState(() {
      isLoading = true;
      result = null;
    });

    try {
      List<double> objectiveCoefficients = [];
      for (var controller in objectiveControllers) {
        double? value = double.tryParse(controller.text);
        if (value == null) {
          throw Exception(
              'Coeficiente de función objetivo inválido: "${controller.text}"');
        }
        objectiveCoefficients.add(value);
      }

      List<List<double>> constraintMatrix = [];
      for (int i = 0; i < numConstraints; i++) {
        List<double> row = [];
        for (int j = 0; j < numVariables; j++) {
          double? value = double.tryParse(constraintControllers[i][j].text);
          if (value == null) {
            throw Exception(
                'Coeficiente de restricción inválido: "${constraintControllers[i][j].text}"');
          }
          row.add(value);
        }
        constraintMatrix.add(row);
      }

      List<double> rightHandSide = [];
      for (var controller in rhsControllers) {
        double? value = double.tryParse(controller.text);
        if (value == null) {
          throw Exception(
              'Valor del lado derecho inválido: "${controller.text}"');
        }
        rightHandSide.add(value);
      }

      SimplexSolver solver = SimplexSolver();
      result = solver.solve(
        objectiveCoefficients: objectiveCoefficients,
        constraintMatrix: constraintMatrix,
        rightHandSide: rightHandSide,
        isMaximization: isMaximization,
      );
    } catch (e) {
      result = SimplexResult(
        isOptimal: false,
        isUnbounded: false,
        isInfeasible: true,
        error: e.toString(),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _loadExampleProblem() {
    setState(() {
      numVariables = 2;
      numConstraints = 2;
      isMaximization = true;

      _numVariablesController.text = '2';
      _numConstraintsController.text = '2';

      _initializeControllers();

      objectiveControllers[0].text = '3';
      objectiveControllers[1].text = '2';

      constraintControllers[0][0].text = '1';
      constraintControllers[0][1].text = '1';
      rhsControllers[0].text = '4';

      constraintControllers[1][0].text = '2';
      constraintControllers[1][1].text = '1';
      rhsControllers[1].text = '6';

      result = null;
    });
  }

  void _clearProblem() {
    setState(() {
      for (var controller in objectiveControllers) {
        controller.text = '0';
      }

      for (var row in constraintControllers) {
        for (var controller in row) {
          controller.text = '0';
        }
      }

      for (var controller in rhsControllers) {
        controller.text = '0';
      }

      result = null;
    });
  }
}
