import 'dart:ui';

import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/section_model.dart';
import 'package:flow_sync/features/comments/ui/comments_screen.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/features/labels/ui/labels_screen.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/network_service.dart';
import '../../../constants/enums.dart';
import '../../../services/provider_service.dart';
import '../../../services/state_service.dart';
import '../model/dashboard_items_model.dart';
import '../model/task_model.dart';

class DashboardViewModel extends BaseViewModel {
  List<Project> listOfProjects = [
    Project(
        id: LanguageService.getString.id,
        order: 0,
        color: LanguageService.getString.color,
        name: LanguageService.getString.name,
        commentCount: 0,
        isShared: false,
        isFavorite: false,
        isInboxProject: false,
        isTeamInbox: false,
        url: LanguageService.getString.url,
        viewStyle: LanguageService.getString.viewstyle),
  ];
  List<Task> listOfTasks = [];
  List<Label> listOfLabels = [];
  List<Section> listOfSections = [];

  List<DashboardItemsModel> dashboardItems = [
    DashboardItemsModel(
        iconPath: AppAssets.allProjects,
        label: LanguageService.getString.loading,
        length: 0,
        type: DashboardItemType.dummy),
  ];

  List<DashboardItemsModel> get dashboardItemsSkeleton => [
        DashboardItemsModel(
            iconPath: AppAssets.allProjects,
            label: LanguageService.getString.loading,
            length: 0,
            type: DashboardItemType.totalProjects),
        DashboardItemsModel(
            iconPath: AppAssets.comments,
            label: LanguageService.getString.loading,
            length: 0,
            type: DashboardItemType.totalComments),
        DashboardItemsModel(
            iconPath: AppAssets.personalLabels,
            label: LanguageService.getString.loading,
            length: 0,
            type: DashboardItemType.activeTasks),
        DashboardItemsModel(
            iconPath: AppAssets.labels,
            label: LanguageService.getString.loading,
            length: 0,
            type: DashboardItemType.labels),
      ];

  @override
  void callDispose() {
    listOfProjects = [
      Project(
          id: LanguageService.getString.id,
          order: 0,
          color: LanguageService.getString.color,
          name: LanguageService.getString.name,
          commentCount: 0,
          isShared: false,
          isFavorite: false,
          isInboxProject: false,
          isTeamInbox: false,
          url: LanguageService.getString.url,
          viewStyle: LanguageService.getString.viewstyle),
    ];
    listOfTasks = [];
    listOfLabels = [];
    dashboardItems = [
      DashboardItemsModel(
          iconPath: AppAssets.allProjects,
          label: LanguageService.getString.loading,
          length: 0,
          type: DashboardItemType.dummy),
    ];
    listOfSections = [];
  }

  @override
  void callInitState() {
    initialize();
  }

  Future<void> initialize() async {
    final projectProvider =
        StateService.context.read(ProviderService.projectProvider);
    final networkService = locator<NetworkService>();
    listOfProjects = await networkService.getAllProjects();
    listOfProjects.removeWhere((element) => element.viewStyle == LanguageService.getString.list);
    listOfProjects.removeWhere((element) => element.id == LanguageService.getString.id);
    listOfTasks = await networkService.getAllActiveTasks();
    listOfSections = await networkService.getAllSections();
    int commentsCount = 0;
    for (var task in listOfTasks) {
      commentsCount = commentsCount + (task.commentCount ?? 0);
    }
    for (var project in listOfProjects) {
      commentsCount = commentsCount + project.commentCount;
    }
    listOfLabels = await networkService.getAllPersonalLabels();

    projectProvider.generateProjectCards();
    dashboardItems.clear();
    dashboardItems.add(DashboardItemsModel(
        iconPath: AppAssets.allProjects,
        label: LanguageService.getString.totalProjects,
        length: listOfProjects.length,
        type: DashboardItemType.totalProjects));
    dashboardItems.add(DashboardItemsModel(
        iconPath: AppAssets.comments,
        label: LanguageService.getString.totalComments,
        length: commentsCount,
        type: DashboardItemType.totalComments));
    dashboardItems.add(DashboardItemsModel(
        iconPath: AppAssets.labels,
        label: LanguageService.getString.totalTasks,
        length: listOfTasks.length,
        type: DashboardItemType.activeTasks));
    dashboardItems.add(DashboardItemsModel(
        iconPath: AppAssets.personalLabels,
        label: LanguageService.getString.labels,
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
