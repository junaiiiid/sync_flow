import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/local_storage_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeEngineService extends ChangeNotifier {
  bool _isDarkModeEnabled = false;

  bool get isDarkModeEnabled => _isDarkModeEnabled;

  set isDarkModeEnabled(bool value) {
    _isDarkModeEnabled = value;
    notifyListeners();
  }

  void initialize(){
    _isDarkModeEnabled = locator<LocalStorageService>().getDarkMode() ?? false;
  }

  Future<void> changeThemeMode({required bool value}) async{
    await locator<LocalStorageService>().setDarkMode(value: value);
    _isDarkModeEnabled = value;
  }

  Color get blue =>
      _isDarkModeEnabled ? DarkModeColors.blue : LightModeColors.blue;
  Color get grey =>
      _isDarkModeEnabled ? DarkModeColors.grey : LightModeColors.grey;
  Color get red =>
      _isDarkModeEnabled ? DarkModeColors.red : LightModeColors.red;
  Color get light =>
      _isDarkModeEnabled ? DarkModeColors.light : LightModeColors.light;
  Color get black =>
      _isDarkModeEnabled ? DarkModeColors.black : LightModeColors.black;
  Color get textColor =>
      _isDarkModeEnabled ? DarkModeColors.white : LightModeColors.white;
  Color get appBarColor => _isDarkModeEnabled ? DarkModeColors.coolBlack : LightModeColors.grey;
  Color get backgroundColor => _isDarkModeEnabled ? DarkModeColors.black : LightModeColors.white;
  Color get white =>
      _isDarkModeEnabled ? DarkModeColors.white : LightModeColors.white;
  Color get error =>
      _isDarkModeEnabled ? DarkModeColors.error : LightModeColors.error;
  Color get success =>
      _isDarkModeEnabled ? DarkModeColors.success : LightModeColors.success;
  Color get transparent => _isDarkModeEnabled
      ? DarkModeColors.transparent
      : LightModeColors.transparent;
}
