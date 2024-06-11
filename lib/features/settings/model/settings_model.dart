import '../../../constants/enums.dart';

class SettingsModel{
  String title;
  List<String>? possibleValues;
  SettingType type;
  bool? value;

  SettingsModel({required this.title, this.possibleValues,required  this.type, this.value});
}