import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simulador_decisiones/objects/Matrix.dart';
import 'package:simulador_decisiones/objects/table_cell_object.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class CustomTable extends StatefulWidget {
  final Matrix matrix;
  const CustomTable({super.key, required this.matrix});

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  final double cellSide = 60;
  final Color staticsColor = const Color.fromARGB(255, 194, 194, 194);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
            height: (widget.matrix.rows > 5)
                ? 6 * cellSide
                : (widget.matrix.rows + 1) * cellSide,
            width: 2 +
                ((widget.matrix.cols > 5)
                    ? cellSide * 6
                    : cellSide * (widget.matrix.cols + 1)),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: getGrid(widget.matrix)));
  }

  Widget getGrid(Matrix matrix) {
    List<List<TableCellObject>> tableCellObjects = List.empty(growable: true);

    for (int i = 0; i < matrix.rows; i++) {
      List<TableCellObject> cellObjects = List.empty(growable: true);

      for (int y = 0; y < matrix.cols; y++) {
        if (y == 0) {
          cellObjects.add(TableCellObject(value: "A${i + 1}"));
        }

        cellObjects.add(TableCellObject(
            value: "(${matrix.matrix[i][y].x}, ${matrix.matrix[i][y].y})",
            isClickeable: true,
            isFromMatrix: true,
            matrixXPos: i,
            matrixYPos: y));
      }

      if (i == 0) {
        List<TableCellObject> firsCellObjects = List.empty(growable: true);
        for (int z = 0; z <= cellObjects.length; z++) {
          firsCellObjects.add(TableCellObject(value: (z > 0) ? "E$z" : ""));
        }
        tableCellObjects.add(firsCellObjects);
      }

      tableCellObjects.add(cellObjects);
    }

    return TableView.builder(
      pinnedColumnCount: 1,
      pinnedRowCount: 1,
      diagonalDragBehavior: DiagonalDragBehavior.free,
      // dragStartBehavior: DragStartBehavior.down,
      cellBuilder: (BuildContext context, TableVicinity vicinity) {
        TableCellObject tableCellObject =
            tableCellObjects[vicinity.row][vicinity.column];

        Color backgroundColor, textColor;

        if (vicinity.column == 0 && vicinity.row == 0) {
          backgroundColor = Colors.black;
          textColor = Colors.black;
        } else if (vicinity.column == 0 || vicinity.row == 0) {
          backgroundColor = Theme.of(context).primaryColor;
          textColor = Colors.white;
        } else {
          backgroundColor = Colors.white;
          textColor = Colors.black;
        }

        return TableViewCell(
          child: Container(
            color: backgroundColor,
            height: cellSide,
            width: cellSide,
            child: Center(
              child: TextButton(
                onPressed: () {
                  _dialogBuilder(context, tableCellObject);
                },
                child: Text(
                  tableCellObject.value,
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
          ),
        );
      },
      columnCount: matrix.cols + 1,
      columnBuilder: (int column) {
        return TableSpan(
          extent: FixedTableSpanExtent(cellSide),
          backgroundDecoration: TableSpanDecoration(
              color: (column != 0)
                  ? Colors.white
                  : Theme.of(context).primaryColor),
          foregroundDecoration: TableSpanDecoration(
            border: TableSpanBorder(
              trailing: BorderSide(
                color: (column != matrix.cols) ? Colors.grey : Colors.white,
                width: 0.5,
                style: BorderStyle.solid,
              ),
            ),
          ),
        );
      },
      rowCount: matrix.rows + 1,
      rowBuilder: (int row) {
        return TableSpan(
            extent: FixedTableSpanExtent(cellSide),
            backgroundDecoration: TableSpanDecoration(
              color: Theme.of(context).primaryColor,
            ),
            foregroundDecoration: TableSpanDecoration(
              border: TableSpanBorder(
                trailing: BorderSide(
                  color: (row != matrix.rows) ? Colors.grey : Colors.white,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
              ),
            ));
      },
    );
  }

  Future<void> _dialogBuilder(
      BuildContext context, TableCellObject tableCellObject) {
    TextStyle textStyle = TextStyle(fontSize: cellSide);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Cambiar (E${tableCellObject.matrixYPos + 1}, A${tableCellObject.matrixXPos + 1})'),
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("(", style: textStyle),
                TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    constraints: BoxConstraints.loose(Size(cellSide, cellSide)),
                    border: const OutlineInputBorder(),
                    hintText:
                        "${widget.matrix.matrix[tableCellObject.matrixXPos][tableCellObject.matrixYPos].x}",
                  ),
                ),
                Text(",", style: textStyle),
                TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    constraints: BoxConstraints.loose(Size(cellSide, cellSide)),
                    border: const OutlineInputBorder(),
                    hintText:
                        "${widget.matrix.matrix[tableCellObject.matrixXPos][tableCellObject.matrixYPos].y}",
                  ),
                ),
                Text(")", style: textStyle)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Guardar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
