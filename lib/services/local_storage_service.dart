import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _key = "dark_mode_enabled";

  late SharedPreferences _sharedPreferences;
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (!_sharedPreferences.containsKey(_key)) {
      _sharedPreferences.setBool(_key, true);
    }
  }

  Future<void> setDarkMode({required bool value}) async {
    await _sharedPreferences.setBool(_key, value);
  }

  bool? getDarkMode() {
    return _sharedPreferences.getBool(_key);
  }
}
