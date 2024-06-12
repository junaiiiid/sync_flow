import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/features/settings/model/settings_model.dart';

class SettingsViewModel extends BaseViewModel {
  List<SettingsModel> settingsMenuItems = [
    SettingsModel(title: "Dark Theme", type: SettingType.boolean, value: false),
    SettingsModel(
      title: "App Type",
      type: SettingType.multiOption,
      possibleValues: ['Simple', 'Advanced'],
    ),
  ];
  @override
  void callDispose() {
    // TODO: implement callDispose
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
