import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/section_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/global_widgets/app_popups.dart';
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
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';

import '../model/tabs_model.dart';

class BoardViewModel extends BaseViewModel {
  List<Section> listOfSections = [
    Section(id: LanguageService.getString.id, projectId: LanguageService.getString.projectid, order: 0, name: LanguageService.getString.name)
  ];

  Project _selectedProject = Project(
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
      viewStyle: LanguageService.getString.viewstyle);

  Project get selectedProject => _selectedProject;

  set selectedProject(Project value) {
    _selectedProject = value;
    setState();
  }

  List<Project> get listOfProjects => StateService.context
      .read(ProviderService.dashboardProvider)
      .listOfProjects;

  Future<void> getSectionsOfSelectedProject() async {
    final networkService = locator<NetworkService>();
    listOfSections = await networkService.getAllSectionsOfProjectById(
        projectId: selectedProject.id ?? "");
    if (listOfSections.isNotEmpty) {
      listOfSections.removeWhere((element) => element.id == LanguageService.getString.id);
    }
    setState();
  }

  List<TabsModel> getTabModel() {
    List<TabsModel> tabsModel = [];
    for (Section section in listOfSections) {
      String sectionName = section.name.toLowerCase();
      if (sectionName.contains(LanguageService.getString.to) || sectionName.contains(LanguageService.getString.doKey)) {
        tabsModel.add(TabsModel(
            tabName: section.name,
            iconPath: AppAssets.todo,
            sectionId: section.id!));
      } else if (sectionName.contains(LanguageService.getString.progress)) {
        tabsModel.add(TabsModel(
            tabName: section.name,
            iconPath: AppAssets.inProgress,
            sectionId: section.id!));
      } else if (sectionName.contains(LanguageService.getString.complete)) {
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
    filteredTasksList.removeWhere((element) =>
    element.labels == null || !element.labels!.contains(sectionId));
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
    StateService.pop();
  }

  @override
  void callDispose() {
    _selectedProject = Project(
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
        viewStyle: LanguageService.getString.viewstyle);
    listOfSections = [
      Section(id: LanguageService.getString.id, projectId: LanguageService.getString.projectid, order: 0, name: LanguageService.getString.name)
    ];
  }

  @override
  void callInitState() {}
}
