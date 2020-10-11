class Global {
  Global._internal();
  static final Global _instance = Global._internal();

  factory Global() {
    return _instance;
  }

  static final bool isDebugMode = true;
}
