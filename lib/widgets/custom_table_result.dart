import 'package:flutter/material.dart';
import 'package:simulador_decisiones/objects/index.dart';
import 'package:simulador_decisiones/objects/vector.dart';

class CustomTableResult extends StatefulWidget {
  final Vector vector;
  final String model;
  const CustomTableResult(
      {super.key, required this.vector, required this.model});

  @override
  State<CustomTableResult> createState() => _CustomTableResultState();
}

class _CustomTableResultState extends State<CustomTableResult> {
  final double cellSide = 60;
  final Color staticsColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Center(child: _getTable()),
        ),
      ),
    );
  }

  Widget _getTable() {
    final matrix = widget.vector.matrix!;
    return Table(
      defaultColumnWidth: const FixedColumnWidth(80),
      children: List.generate(matrix.length, (i) {
        bool isHigherRow = _isHigherRow(i);
        return TableRow(
          children: List.generate(
              matrix[i].length + ((widget.model == 'Laplace' || widget.model == 'Hurwics') ? 1 : 0), (j) {
            bool isHigh = _isInHighIndexes(i, j);
            bool isLow = _isInLowIndexes(i, j);
            bool isHigher = _isHigher(i, j);
            bool isLower = _isLower(i, j);

            // 'Maximax', 'Maximin', 'Laplace', 'Hurwics', 'Savage'
            if ((widget.model == 'Laplace' || widget.model == 'Hurwics') &&
                j == matrix[i].length) {
              return Container(
                height: cellSide,
                width: cellSide,
                alignment: Alignment.center,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isHigherRow ? Colors.red : Colors.greenAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: Text(
                  (widget.model == 'Laplace')
                      ? "Prom.\n${widget.vector.averages![i].toStringAsFixed(2)}"
                      : (widget.model == 'Hurwics')
                          ? widget.vector.hurwicz![i].toStringAsFixed(2)
                          : "",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              );
            }
            return Container(
              height: cellSide,
              width: cellSide,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: (isHigh || isHigher || isHigherRow)
                    ? Colors.red
                    : (isLow || isLower)
                        ? Colors.blue
                        : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    color:
                        (isHigher || isHigherRow || isLower) ? Colors.black : Colors.grey,
                    width: (isHigher || isHigherRow || isLower) ? 3 : 1),
              ),
              child: Text(
                '${matrix[i][j]}',
                style: const TextStyle(fontSize: 12),
              ),
            );
          }),
        );
      }),
    );
  }

  bool _isInHighIndexes(int x, int y) {
    if (widget.vector.highIndexes == null ||
        widget.vector.highIndexes!.isEmpty) {
      return false;
    }

    for (Index i in widget.vector.highIndexes!) {
      if (i.x == x && i.y == y) {
        return true;
      }
    }

    return false;
  }

  bool _isInLowIndexes(int x, int y) {
    if (widget.vector.lowIndexes == null || widget.vector.lowIndexes!.isEmpty) {
      return false;
    }

    for (Index i in widget.vector.lowIndexes!) {
      if (i.x == x && i.y == y) {
        return true;
      }
    }

    return false;
  }

  bool _isHigher(int x, int y) {
    if (widget.vector.higher == null) {
      return false;
    }

    if (widget.vector.higher!.x == x && widget.vector.higher!.y == y) {
      return true;
    }

    return false;
  }

  bool _isLower(int x, int y) {
    if (widget.vector.lower == null) {
      return false;
    }

    if (widget.vector.lower!.x == x && widget.vector.lower!.y == y) {
      return true;
    }

    return false;
  }

  bool _isHigherRow(int x) {
    if (widget.vector.higherRow == null) {
      return false;
    }

    if (widget.vector.higherRow! == x) {
      return true;
    }

    return false;
  }
}
