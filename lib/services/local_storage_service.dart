import 'dart:convert';

import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/global_widgets/app_popups.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/task_timer/model/timer_task_model.dart';

class LocalStorageService {
  static const String _key = "dark_mode_enabled";
  static const String tasks = "active_tasks";

  late SharedPreferences _sharedPreferences;
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (!_sharedPreferences.containsKey(_key)) {
      _sharedPreferences.setBool(_key, false);
    }
  }

  Future<void> setDarkMode({required bool value}) async {
    await _sharedPreferences.setBool(_key, value);
  }

  bool? getDarkMode() {
    return _sharedPreferences.getBool(_key);
  }

  Future<void> modifyATaskTimer({required TimerTaskModel model,required String messageToShow}) async {
    ///If the task list does not exist create it
    if (!_sharedPreferences.containsKey(tasks)) {
      await _sharedPreferences.setStringList(tasks, []);
    } else {
      List<String>? activeTasksList = _sharedPreferences.getStringList(tasks);
      final key = '${model.task?.id}';
      ///If the task List does not contain our key then we create it
      if(activeTasksList!.isEmpty || !(activeTasksList.contains(key))){
        activeTasksList?.add(model.task?.id ?? '');
        await _sharedPreferences.setStringList(tasks, activeTasksList??[]);
      }
      await _sharedPreferences.setString(key, jsonEncode(model).toString());
    }
    AppPopups.showSnackBar(
        type: SnackBarTypes.success,
        content: messageToShow);
  }

  List<String>? getTasksHistory(){
    return _sharedPreferences.getStringList(tasks);
  }

  TimerTaskModel? getTimerTaskModel({required String id}){
    String? jsonString = _sharedPreferences.getString(id);
    if(jsonString!=null){
      Map<String, dynamic> map = jsonDecode(jsonString);
      return TimerTaskModel.fromJson(map);
    }
  }
}
