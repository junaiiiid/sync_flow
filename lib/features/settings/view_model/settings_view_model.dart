import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/features/settings/model/settings_model.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../services/language_service.dart';

class SettingsViewModel extends BaseViewModel {
  List<SettingsModel> settingsMenuItems = [
    SettingsModel(title: LanguageService.getString.darkTheme, type: SettingType.boolean, value: false),
    SettingsModel(
      title: LanguageService.getString.appType,
      type: SettingType.multiOption,
      possibleValues: [LanguageService.getString.simple, LanguageService.getString.advanced],
    ),
  ];
  @override
  void callDispose() {
    settingsMenuItems = [
      SettingsModel(title: LanguageService.getString.darkTheme, type: SettingType.boolean, value: false),
      SettingsModel(
        title: LanguageService.getString.appType,
        type: SettingType.multiOption,
        possibleValues: [LanguageService.getString.simple, LanguageService.getString.advanced],
      ),
    ];
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
