import 'package:simulador_decisiones/logic/decision_models.dart';
import 'package:simulador_decisiones/objects/vector.dart';

class VectorController {
  Vector? vector;
  int minCols = 1, minRows = 1;

  void addColumn() {
    if (vector == null || vector!.matrix!.isEmpty) return;

    List<List<double>> copy = copyMatrix(vector!.matrix!);

    for (List<double> row in copy) {
      row.add(0);
    }

    vector!.matrix = copy;
    print(vector!.matrix!);
  }

  void addRow() {
    if (vector == null || vector!.matrix == null || vector!.matrix!.isEmpty) {
      return;
    }
    List<List<double>> copy = copyMatrix(vector!.matrix!);
    int columns = copy.first.length;
    copy.add(List.filled(columns, 0));
    vector!.matrix = copy;
    print(vector!.matrix!);
  }

  void removeLastRow() {
    if (vector == null ||
        vector!.matrix == null ||
        vector!.matrix!.isEmpty ||
        vector!.matrix!.length <= minRows) {
      return;
    }
    List<List<double>> copy = copyMatrix(vector!.matrix!);
    copy.removeLast();
    vector!.matrix = copy;
    print(vector!.matrix!);
  }

  void removeLastColumn() {
    if (vector == null || vector!.matrix == null || vector!.matrix!.isEmpty) {
      return;
    }
    List<List<double>> copy = copyMatrix(vector!.matrix!);

    int columns = copy.first.length;

    if (columns <= minCols) {
      return;
    }

    for (var row in copy) {
      row.removeLast();
    }

    vector!.matrix = copy;
    print(vector!.matrix!);
  }
}
