import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  SharedPrefsHelper._();

  static final SharedPrefsHelper instance = SharedPrefsHelper._();

  static late SharedPreferences _sharedPreferences;

  static Future<void> initShared() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getStringValue(String key) => _sharedPreferences.getString(key);
  bool? getBoolValue(String key) => _sharedPreferences.getBool(key);
  List<String>? getStringListValue(String key) =>
      _sharedPreferences.getStringList(key);

  Future<bool?> setStringValue(String key, String value) async =>
      await _sharedPreferences.setString(key, value);

  Future<bool?> setBoolValue(String key, bool value) async =>
      await _sharedPreferences.setBool(key, value);

  Future<bool?> setStringListValue(String key, List<String> value) async =>
      await _sharedPreferences.setStringList(key, value);

  Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }
}
