import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/app_assets.dart';

import '../model/dashboard_items_model.dart';

class DashboardViewModel extends BaseViewModel{
  List<DashboardItemsModel> dashboardItems = [
    DashboardItemsModel(iconPath: AppAssets.allProjects, label: "Total Projects", length: 1),
    DashboardItemsModel(iconPath: AppAssets.comments, label: "Total Comments", length: 2),
    DashboardItemsModel(iconPath: AppAssets.personalLabels, label: "Personal Labels", length: 1),
    DashboardItemsModel(iconPath: AppAssets.labels, label: "Labels", length: 1),
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