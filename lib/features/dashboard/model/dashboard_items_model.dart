import 'package:flow_sync/features/dashboard/model/project_model.dart';

class DashboardItemsModel {
  Project? projectModel;
  String iconPath;
  String label;
  int length;

  DashboardItemsModel(
      {this.projectModel,
      required this.iconPath,
      required this.label,
      required this.length});
}
