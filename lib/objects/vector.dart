import 'package:simulador_decisiones/objects/index.dart';

class Vector {

  List<List<double>>? matrix;
  List<Index>? highIndexes;
  List<Index>? lowIndexes;
  List<double>? averages;
  List<double>? hurwicz;
  Index? higher, lower;
  int? higherRow;

  Vector({this.matrix});

  @override
  String toString() {
    final buffer = StringBuffer('Vector(');
    if (matrix != null) buffer.write('matrix: $matrix, ');
    if (highIndexes != null) buffer.write('highIndexes: $highIndexes, ');
    if (lowIndexes != null) buffer.write('lowIndexes: $lowIndexes, ');
    if (averages != null) buffer.write('averages: $averages, ');
    if (hurwicz != null) buffer.write('hurwicz: $hurwicz, ');
    if (higher != null) buffer.write('higher: $higher, ');
    if (lower != null) buffer.write('lower: $lower, ');
    if (higherRow != null) buffer.write('higherRow: $higherRow, ');
    var result = buffer.toString();
    if (result.endsWith(', ')) {
      result = result.substring(0, result.length - 2);
    }
    result += ')';
    return result;
  }

}
