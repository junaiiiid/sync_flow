import 'dart:ui';

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
  List<Project> listOfProjects = [
    Project(
        id: "id",
        order: 0,
        color: "color",
        name: "name",
        commentCount: 0,
        isShared: false,
        isFavorite: false,
        isInboxProject: false,
        isTeamInbox: false,
        url: "url",
        viewStyle: "viewStyle"),
  ];
  List<Task> listOfTasks = [];
  List<Label> listOfLabels = [];

  List<DashboardItemsModel> dashboardItems = [
    DashboardItemsModel(
        iconPath: AppAssets.allProjects,
        label: "Loading...",
        length: 0,
        type: DashboardItemType.dummy),
  ];

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
    listOfProjects = [
      Project(
          id: "id",
          order: 0,
          color: "color",
          name: "name",
          commentCount: 0,
          isShared: false,
          isFavorite: false,
          isInboxProject: false,
          isTeamInbox: false,
          url: "url",
          viewStyle: "viewStyle"),
    ];
    listOfTasks = [];
    listOfLabels = [];
    dashboardItems = [
      DashboardItemsModel(
          iconPath: AppAssets.allProjects,
          label: "Loading...",
          length: 0,
          type: DashboardItemType.dummy),
    ];
  }

  @override
  void callInitState() {
    initialize();
  }

  Future<void> initialize() async {
    final projectProvider =
        StateService.context.read(ProviderService.projectProvider);
    final networkService = LocatorService.networkServiceLocator;
    listOfProjects = await networkService.getAllProjects();
    listOfProjects.removeWhere((element) => element.viewStyle == 'list');
    listOfProjects.removeWhere((element) => element.id == 'id');
    listOfTasks = await networkService.getAllActiveTasks();
    int commentsCount = 0;
    for (var task in listOfTasks) {
      commentsCount = commentsCount + task.commentCount;
    }
    for (var project in listOfProjects) {
      commentsCount = commentsCount + project.commentCount;
    }
    listOfLabels = await networkService.getAllPersonalLabels();

    projectProvider.generateProjectCards();
    dashboardItems.clear();
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
        length: listOfLabels.length,
        type: DashboardItemType.labels));
    setState();
  }

  void handleDashBoardIconTap({required DashboardItemType type}) {
    final homeProvider =
        StateService.context.read(ProviderService.homeProvider);
    switch (type) {
      case DashboardItemType.totalProjects:
        homeProvider.selectedItem = homeProvider.navigationBarItems[2];
      case DashboardItemType.totalComments:
        StateService.pushNamed(routeName: CommentsScreen.id);
      case DashboardItemType.activeTasks:
        homeProvider.selectedItem = homeProvider.navigationBarItems[1];
      case DashboardItemType.labels:
        StateService.pushNamed(routeName: LabelsScreen.id);
      case DashboardItemType.dummy:
      // TODO: Handle this case.
    }
  }

  @override
  Future<void> refresh({VoidCallback? action}) async {
    callDispose();
    await initialize();
    if (action != null) {
      action;
    }
  }
}
