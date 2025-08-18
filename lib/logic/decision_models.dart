import 'package:simulador_decisiones/objects/index.dart';
import 'package:simulador_decisiones/objects/vector.dart';

List<List<double>> copyMatrix(List<List<double>> matrix) {
  return matrix.map((row) => row.map((value) => value).toList()).toList();
}

Vector maximax(List<List<double>> matrix) {
  Vector vector = Vector(matrix: matrix);
  vector.highIndexes = List.empty(growable: true);

  for (int i = 0; i < matrix.length; i++) {
    Index? index;
    for (int j = 0; j < matrix[i].length; j++) {
      if (index == null) {
        index = Index(i, j, matrix[i][j]);
        continue;
      }

      if (matrix[i][j] >= index.value!) {
        index.value = matrix[i][j];
        index.x = i;
        index.y = j;
      }
    }
    vector.highIndexes!.add(index!);
  }

  for (Index index in vector.highIndexes!) {
    if (vector.higher == null || index.value! >= vector.higher!.value!) {
      vector.higher = index;
    }
  }

  return vector;
}

Vector maximin(List<List<double>> matrix) {
  Vector vector = Vector(matrix: matrix);
  vector.lowIndexes = List.empty(growable: true);

  for (int i = 0; i < matrix.length; i++) {
    Index? index;
    for (int j = 0; j < matrix[i].length; j++) {
      if (index == null) {
        index = Index(i, j, matrix[i][j]);
        continue;
      }

      if (matrix[i][j] <= index.value!) {
        index.value = matrix[i][j];
        index.x = i;
        index.y = j;
      }
    }
    vector.lowIndexes!.add(index!);
  }

  for (Index index in vector.lowIndexes!) {
    if (vector.higher == null || index.value! >= vector.higher!.value!) {
      vector.higher = index;
    }
  }

  return vector;
}

Vector laplace(List<List<double>> matrix) {
  Vector vector = Vector(matrix: matrix);

  vector.averages = List.empty(growable: true);

  for (List<double> row in matrix) {
    double sum = row.reduce((a, b) => a + b);
    double avg = sum / row.length;
    vector.averages!.add(avg);
  }

  vector.higherRow = vector.averages!.indexOf(
    vector.averages!.reduce((a, b) => (a > b) ? a : b),
  );

  return vector;
}

Vector hurwicz(List<List<double>> matrix, double percent) {
  Vector vector = Vector(matrix: matrix);
  vector.hurwicz = List.empty(growable: true);

  for (List<double> row in matrix) {
    double higher = row.reduce((a, b) => (a > b) ? a : b);
    double lower = row.reduce((a, b) => (a < b) ? a : b);
    print('($higher * $percent) + ($lower * ${(1 - percent)})');
    double hurwiczValue = (higher * percent) + (lower * (1 - percent));
    vector.hurwicz!.add(hurwiczValue);
  }

  vector.higherRow = vector.hurwicz!.indexOf(
    vector.hurwicz!.reduce((a, b) => (a > b) ? a : b),
  );

  return vector;
}

Vector savage(List<List<double>> matrix) {
  Vector vector = Vector(matrix: matrix);

  List<List<double>> invertedMatrix = List.generate(
    vector.matrix![0].length,
    (j) => List.generate(vector.matrix!.length, (i) => vector.matrix![i][j]),
  );

  for (List<double> row in invertedMatrix) {
    double higher = row.reduce((a, b) => a > b ? a : b);
    for(int i = 0; i < row.length ; i++) {
      row[i] = higher - row[i];
    }
  }

  List<List<double>> reInvertedMatrix = List.generate(
    invertedMatrix[0].length,
    (j) => List.generate(invertedMatrix.length, (i) => invertedMatrix[i][j]),
  );
  
  Vector result = minimax(reInvertedMatrix);

  return result;
}

Vector minimax(List<List<double>> matrix) {
  Vector vector = Vector(matrix: matrix);
  vector.highIndexes = List.empty(growable: true);

  for (int i = 0; i < matrix.length; i++) {
    Index? index;
    for (int j = 0; j < matrix[i].length; j++) {
      if (index == null) {
        index = Index(i, j, matrix[i][j]);
        continue;
      }

      if (matrix[i][j] >= index.value!) {
        index.value = matrix[i][j];
        index.x = i;
        index.y = j;
      }
    }
    vector.highIndexes!.add(index!);
  }

  for (Index index in vector.highIndexes!) {
    if (vector.lower == null || index.value! <= vector.lower!.value!) {
      vector.lower = index;
    }
  }

  return vector;
}
