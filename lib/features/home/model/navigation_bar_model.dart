import '../../../constants/enums.dart';

class NavigationBarModel{
  bool isActive;
  NavigationBarItems type;
  String icon;
  String label;

  NavigationBarModel({required this.isActive, required this.type,required this.icon,required this.label});
}