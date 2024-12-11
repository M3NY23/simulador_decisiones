class TableCellObject {
  String value;
  bool isClickeable, isFromMatrix;
  int matrixXPos, matrixYPos;

  TableCellObject(
      {this.value = "",
      this.isClickeable = false,
      this.isFromMatrix = false,
      this.matrixXPos = -1,
      this.matrixYPos = -1});

  @override
  String toString() {
    return "{value=$value isClickeable=$isClickeable isFromMatrix=$isFromMatrix matrixXPos=$matrixXPos matrixYPos=$matrixYPos}";
  }
}
