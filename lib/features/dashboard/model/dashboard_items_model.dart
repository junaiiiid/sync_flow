import 'package:flow_sync/features/dashboard/model/project_model.dart';

import '../../../constants/enums.dart';

class DashboardItemsModel {
  Project? projectModel;
  String iconPath;
  String label;
  int length;
  DashboardItemType type;

  DashboardItemsModel(
      {this.projectModel,
      required this.iconPath,
      required this.label,
      required this.length,
      required this.type});
}
