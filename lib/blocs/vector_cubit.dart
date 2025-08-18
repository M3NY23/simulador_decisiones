import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulador_decisiones/objects/vector.dart';

class VectorCubit extends Cubit<Vector> {
  static const int _minCols = 1;
  static const int _minRows = 1;

  VectorCubit() : super(Vector());

  /// Inicializa el vector con una matriz vacía o con dimensiones específicas
  void initializeVector({int? rows, int? cols}) {
    final newVector = Vector();
    if (rows != null && cols != null && rows > 0 && cols > 0) {
      newVector.matrix = List.generate(
        rows,
        (_) => List.filled(cols, 0.0),
      );
    } else {
      newVector.matrix = [
        [0.0]
      ];
    }
    emit(newVector);
  }

  /// Agrega una columna al final de la matriz
  void addColumn() {
    if (state.matrix == null || state.matrix!.isEmpty) return;
    
    final newMatrix = state.matrix!.map((row) => [...row, 0.0]).toList();
    final newVector = Vector(matrix: newMatrix);
    
    // Preservar otros valores del estado anterior
    newVector.highIndexes = state.highIndexes;
    newVector.lowIndexes = state.lowIndexes;
    newVector.averages = state.averages;
    newVector.hurwicz = state.hurwicz;
    newVector.higher = state.higher;
    newVector.lower = state.lower;
    newVector.higherRow = state.higherRow;
    
    emit(newVector);
  }

  /// Agrega una fila al final de la matriz
  void addRow() {
    if (state.matrix == null || state.matrix!.isEmpty) return;
    
    final columns = state.matrix!.first.length;
    final newMatrix = [
      ...state.matrix!,
      List.filled(columns, 0.0),
    ];
    final newVector = Vector(matrix: newMatrix);
    
    // Preservar otros valores del estado anterior
    newVector.highIndexes = state.highIndexes;
    newVector.lowIndexes = state.lowIndexes;
    newVector.averages = state.averages;
    newVector.hurwicz = state.hurwicz;
    newVector.higher = state.higher;
    newVector.lower = state.lower;
    newVector.higherRow = state.higherRow;
    
    emit(newVector);
  }

  /// Elimina la última fila de la matriz
  void removeLastRow() {
    if (state.matrix == null || 
        state.matrix!.isEmpty || 
        state.matrix!.length <= _minRows) {
      return;
    }
    
    final newMatrix = state.matrix!.sublist(0, state.matrix!.length - 1);
    final newVector = Vector(matrix: newMatrix);
    
    // Preservar otros valores del estado anterior
    newVector.highIndexes = state.highIndexes;
    newVector.lowIndexes = state.lowIndexes;
    newVector.averages = state.averages;
    newVector.hurwicz = state.hurwicz;
    newVector.higher = state.higher;
    newVector.lower = state.lower;
    newVector.higherRow = state.higherRow;
    
    emit(newVector);
  }

  /// Elimina la última columna de la matriz
  void removeLastColumn() {
    if (state.matrix == null || 
        state.matrix!.isEmpty ||
        state.matrix!.first.length <= _minCols) {
      return;
    }
    
    final newMatrix = state.matrix!.map((row) {
      if (row.isEmpty) return <double>[];
      return row.sublist(0, row.length - 1);
    }).toList();
    
    final newVector = Vector(matrix: newMatrix);
    
    // Preservar otros valores del estado anterior
    newVector.highIndexes = state.highIndexes;
    newVector.lowIndexes = state.lowIndexes;
    newVector.averages = state.averages;
    newVector.hurwicz = state.hurwicz;
    newVector.higher = state.higher;
    newVector.lower = state.lower;
    newVector.higherRow = state.higherRow;
    
    emit(newVector);
  }

  /// Actualiza un valor específico en la matriz
  void updateMatrixValue(int row, int col, double value) {
    if (state.matrix == null || 
        row < 0 || 
        row >= state.matrix!.length ||
        col < 0 || 
        col >= state.matrix![row].length) {
      return;
    }
    
    final newMatrix = state.matrix!.map((r) => [...r]).toList();
    newMatrix[row][col] = value;
    
    final newVector = Vector(matrix: newMatrix);
    
    // Preservar otros valores del estado anterior
    newVector.highIndexes = state.highIndexes;
    newVector.lowIndexes = state.lowIndexes;
    newVector.averages = state.averages;
    newVector.hurwicz = state.hurwicz;
    newVector.higher = state.higher;
    newVector.lower = state.lower;
    newVector.higherRow = state.higherRow;
    
    emit(newVector);
  }

  /// Limpia toda la matriz y reinicia el vector
  void clearMatrix() {
    emit(Vector());
  }

  /// Actualiza los cálculos del vector (índices altos, bajos, promedios, etc.)
  void updateCalculations({
    List<dynamic>? highIndexes,
    List<dynamic>? lowIndexes,
    List<double>? averages,
    List<double>? hurwicz,
    dynamic higher,
    dynamic lower,
    int? higherRow,
  }) {
    final newVector = Vector(matrix: state.matrix);
    
    if (highIndexes != null) newVector.highIndexes = highIndexes.cast();
    if (lowIndexes != null) newVector.lowIndexes = lowIndexes.cast();
    if (averages != null) newVector.averages = averages;
    if (hurwicz != null) newVector.hurwicz = hurwicz;
    if (higher != null) newVector.higher = higher;
    if (lower != null) newVector.lower = lower;
    if (higherRow != null) newVector.higherRow = higherRow;
    
    emit(newVector);
  }

  /// Obtiene el número de filas actuales
  int get currentRows => state.matrix?.length ?? 0;

  /// Obtiene el número de columnas actuales
  int get currentCols => state.matrix?.isEmpty == true ? 0 : (state.matrix?.first.length ?? 0);

  /// Verifica si se puede agregar una fila
  bool get canAddRow => state.matrix != null && state.matrix!.isNotEmpty;

  /// Verifica si se puede agregar una columna
  bool get canAddColumn => state.matrix != null && state.matrix!.isNotEmpty;

  /// Verifica si se puede eliminar una fila
  bool get canRemoveRow => currentRows > _minRows;

  /// Verifica si se puede eliminar una columna
  bool get canRemoveColumn => currentCols > _minCols;
}
