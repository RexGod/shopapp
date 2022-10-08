class httpExeption implements Exception {
  final String message;
  httpExeption(this.message);

  @override
  String toString() {
    return message;
  }
}
