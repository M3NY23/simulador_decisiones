import 'package:flutter/material.dart';
import 'package:simulador_decisiones/objects/vector.dart';

class CustomTable extends StatefulWidget {
  final Vector vector;
  final Function(int i, int j)? function;
  const CustomTable({super.key, required this.vector, this.function});

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
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
    return Table(
      defaultColumnWidth: const FixedColumnWidth(100),
      children: [
        for (int i = 0; i < widget.vector.matrix!.length; i++)
          TableRow(
            children: [
              for (int j = 0; j < widget.vector.matrix![i].length; j++)
                Container(
                  height: cellSide,
                  width: cellSide,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.grey)),
                  child: TextButton(
                    onPressed: () async {
                      if (widget.function != null) {
                        await widget.function!(i, j);
                      }
                    },
                    child: Text(
                      '${widget.vector.matrix![i][j]}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
