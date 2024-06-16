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

  Color get blue =>LightModeColors.blue;
  Color get grey =>LightModeColors.grey;
  Color get red =>LightModeColors.red;
  Color get light =>LightModeColors.light;
  Color get black =>LightModeColors.black;
  Color get white =>LightModeColors.white;
  Color get error =>LightModeColors.error;
  Color get success =>LightModeColors.success;
  Color get transparent => _isDarkModeEnabled
      ? DarkModeColors.transparent
      : LightModeColors.transparent;
}
