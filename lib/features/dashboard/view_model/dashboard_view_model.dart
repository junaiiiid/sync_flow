import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/view_model/board_view_model.dart';
import 'package:flow_sync/features/comments/ui/comments_screen.dart';
import 'package:flow_sync/features/dashboard/model/comment_model.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/features/labels/ui/labels_screen.dart';
import 'package:flow_sync/features/projects/view_model/project_view_model.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/dependency_injection/locator_service.dart';
import 'package:flow_sync/services/network_service.dart';

import '../../../constants/enums.dart';
import '../../../services/provider_service.dart';
import '../../../services/state_service.dart';
import '../model/dashboard_items_model.dart';
import '../model/task_model.dart';

class DashboardViewModel extends BaseViewModel {
  List<Project> listOfProjects = [];
  List<Task> listOfTasks = [];
  List<Label> listOfPersonalLabels = [];

  List<DashboardItemsModel> dashboardItems = [];

  List<DashboardItemsModel> get dashboardItemsSkeleton => [
        DashboardItemsModel(
            iconPath: AppAssets.allProjects,
            label: "Loading...",
            length: 0,
            type: DashboardItemType.totalProjects),
        DashboardItemsModel(
            iconPath: AppAssets.comments,
            label: "Loading...",
            length: 0,
            type: DashboardItemType.totalComments),
        DashboardItemsModel(
            iconPath: AppAssets.personalLabels,
            label: "Loading...",
            length: 0,
            type: DashboardItemType.activeTasks),
        DashboardItemsModel(
            iconPath: AppAssets.labels,
            label: "Loading...",
            length: 0,
            type: DashboardItemType.labels),
      ];

  @override
  void callDispose() {
    listOfProjects = [];
    listOfTasks = [];
    listOfPersonalLabels = [];
    dashboardItems = [];
  }

  @override
  void callInitState() {
    initialize();
  }

  Future<void> initialize() async {
    final networkService = LocatorService.networkServiceLocator;
    listOfProjects = await networkService.getAllProjects();
    listOfProjects.removeWhere((element) => element.viewStyle == 'list');
    listOfTasks = await networkService.getAllActiveTasks();
    int commentsCount = 0;
    for (var task in listOfTasks) {
      commentsCount = commentsCount + task.commentCount;
    }
    listOfPersonalLabels = await networkService.getAllPersonalLabels();
    StateService.context
        .read(ProviderService.projectProvider)
        .generateProjectCards();
    dashboardItems.add(DashboardItemsModel(
        iconPath: AppAssets.allProjects,
        label: "Total Projects",
        length: listOfProjects.length,
        type: DashboardItemType.totalProjects));
    dashboardItems.add(DashboardItemsModel(
        iconPath: AppAssets.comments,
        label: "Total Comments",
        length: commentsCount,
        type: DashboardItemType.totalComments));
    dashboardItems.add(DashboardItemsModel(
        iconPath: AppAssets.labels,
        label: "Total Tasks",
        length: listOfTasks.length,
        type: DashboardItemType.activeTasks));
    dashboardItems.add(DashboardItemsModel(
        iconPath: AppAssets.personalLabels,
        label: "Labels",
        length: listOfPersonalLabels.length,
        type: DashboardItemType.labels));
    notifyListeners();
  }

  void handleDashBoardIconTap({required DashboardItemType type}) {
    final homeProvider = StateService.context.read(ProviderService.homeProvider);
    switch (type) {
      case DashboardItemType.totalProjects:
        homeProvider.selectedItem = homeProvider.navigationBarItems[2];
      case DashboardItemType.totalComments:
      StateService.pushNamed(routeName: CommentsScreen.id);
      case DashboardItemType.activeTasks:
        homeProvider.selectedItem = homeProvider.navigationBarItems[1];
      case DashboardItemType.labels:
      StateService.pushNamed(routeName: LabelsScreen.id);
    }
  }
}
