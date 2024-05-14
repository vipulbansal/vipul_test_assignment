import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences _prefs;

  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() => _instance;

  LocalStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool getBool(String key, [bool defaultValue = false]) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  void setBool(String key, bool value) {
    _prefs.setBool(key, value);
  }

  String getString(String key, [String defaultValue = ""]) {
    return _prefs.getString(key) ?? defaultValue;
  }

  void setString(String key, String value) {
    _prefs.setString(key, value);
  }

  Future<bool> remove(String key) async => await _prefs.remove(key);

  removeMultiple(List<String> keys) async {
    await Future.forEach(keys, (element) async {
      await _prefs.remove(element);
    });
  }

  Future<bool> clear() async => await _prefs.clear();
}
