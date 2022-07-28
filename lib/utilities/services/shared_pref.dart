import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _singleton =
      SharedPreferencesService._internal();

  SharedPreferencesService._internal();

  static SharedPreferencesService get instance => _singleton;
  late Future<SharedPreferences> _prefs;

  create() {
    _prefs = SharedPreferences.getInstance();
  }

  void setInt(String key, int value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(key, value);
  }

  Future<int> getInt(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(key) ?? 0;
  }

  void setBool(String key, bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(key, value);
  }

  Future setBoolFuture(String key, bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key) ?? false;
  }

  void setString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }

  Future setStringFuture(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }

  Future<String> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key) ?? "";
  }

  Future<bool> contains(String key) async {
    final SharedPreferences prefs = await _prefs;
    if (!prefs.containsKey(key)) {
      return false;
    }
    return true;
  }

  void clear() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }

  void remove(String key) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }
}
