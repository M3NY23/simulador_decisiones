class Index {
  int? x, y;
  double? value;

  Index(this.x, this.y, this.value);
  Index.value(this.value);
  Index.empty();

  @override
  String toString() {
    return 'Index(x: $x, y: $y, value: $value)';
  }
}
