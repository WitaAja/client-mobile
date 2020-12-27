class Console {
  static void log(Object o) {
    assert(() {
      print(o);
      return true;
    }());
  }
}
