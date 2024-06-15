import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/section_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/global_widgets/app_popups.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/dependency_injection/locator_service.dart';
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:go_router/go_router.dart';

import '../model/tabs_model.dart';

class BoardViewModel extends BaseViewModel {
  List<Section> listOfSections = [
    Section(id: "id", projectId: "projectId", order: 0, name: "name")
  ];

  Project _selectedProject = Project(
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
      viewStyle: "viewStyle");

  Project get selectedProject => _selectedProject;

  set selectedProject(Project value) {
    _selectedProject = value;
    setState();
  }

  List<Project> get listOfProjects => StateService.context
      .read(ProviderService.dashboardProvider)
      .listOfProjects;

  Future<void> getSectionsOfSelectedProject() async {
    final networkService = LocatorService.networkServiceLocator;
    listOfSections = await networkService.getAllSectionsOfProjectById(
        projectId: selectedProject.id ?? "");
    if (listOfSections.isNotEmpty) {
      listOfSections.removeWhere((element) => element.id == "id");
    }
    setState();
  }

  List<TabsModel> getTabModel() {
    List<TabsModel> tabsModel = [];
    for (Section section in listOfSections) {
      String sectionName = section.name.toLowerCase();
      if (sectionName.contains("to") || sectionName.contains("do")) {
        tabsModel.add(TabsModel(
            tabName: section.name,
            iconPath: AppAssets.todo,
            sectionId: section.id!));
      } else if (sectionName.contains("progress")) {
        tabsModel.add(TabsModel(
            tabName: section.name,
            iconPath: AppAssets.inProgress,
            sectionId: section.id!));
      } else if (sectionName.contains("complete")) {
        tabsModel.add(TabsModel(
            tabName: section.name,
            iconPath: AppAssets.completed,
            sectionId: section.id!));
      } else {
        tabsModel.add(TabsModel(
            tabName: section.name,
            iconPath: AppAssets.section,
            sectionId: section.id!));
      }
    }
    return tabsModel;
  }

  List<Task> get tasksList =>
      StateService.context.read(ProviderService.dashboardProvider).listOfTasks;

  List<Task> filterTasksBySectionId({required String sectionId}) {
    List<Task> filteredTasksList = List.from(tasksList);
    filteredTasksList.removeWhere((element) => element.sectionId != sectionId);
    return filteredTasksList;
  }

  Future<void> deleteTasks({required String taskId}) async {
    final dashboardProvider =
        StateService.context.read(ProviderService.dashboardProvider);
    AppPopups.showLoader();
    await locator<NetworkService>().deleteATaskById(taskId: taskId);
    dashboardProvider.listOfTasks
        .removeWhere((element) => element.id == taskId);
    setState();
    StateService.context.pop();
  }

  @override
  void callDispose() {
    _selectedProject = Project(
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
        viewStyle: "viewStyle");
    listOfSections = [
      Section(id: "id", projectId: "projectId", order: 0, name: "name")
    ];
  }

  @override
  void callInitState() {}
}
