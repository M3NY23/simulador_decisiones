import 'package:simulador_decisiones/objects/matrix_box.dart';

class Matrix {
  final List<List<MatrixBox>> _matrix = List.empty(growable: true);

  int cols = 3, rows = 3;

  Matrix() {
    _initMatrix();
  }

  _initMatrix() {
    for (int i = 0; i < rows; i++) {
      List<MatrixBox> row = List.empty(growable: true);
      for (int y = 0; y < cols; y++) {
        row.add(MatrixBox());
      }
      _matrix.add(row);
    }
  }

  addColumn() {
    cols++;
    for (List<MatrixBox> row in _matrix) {
      row.add(MatrixBox());
    }
    print("Se agrego una columna");
  }

  addRow() {
    rows++;
    List<MatrixBox> row = List.empty(growable: true);
    for (int i = 0; i < cols; i++) {
      row.add(MatrixBox());
    }
    _matrix.add(row);
  }

  removeColumn() {
    cols--;
    for (List<MatrixBox> row in _matrix) {
      row.removeLast();
    }
  }

  removeRow() {
    rows--;
    _matrix.removeLast();
  }

  List<List<MatrixBox>> get matrix => _matrix;
}
