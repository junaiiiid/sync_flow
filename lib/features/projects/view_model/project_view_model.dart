import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/section_model.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/global_widgets/app_popups.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';

import '../../dashboard/model/project_model.dart';
import '../model/project_card_model.dart';

class ProjectViewModel extends BaseViewModel {
  List<Project> get projectsList => StateService.context
      .read(ProviderService.dashboardProvider)
      .listOfProjects;

  List<Task> get tasksList =>
      StateService.context.read(ProviderService.dashboardProvider).listOfTasks;

  List<Section> get sectionList =>
      StateService.context.read(ProviderService.dashboardProvider).listOfSections;

  List<ProjectCardModel> listOfProjectCards = [
    ProjectCardModel(
        projectData: Project(
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
        taskCount: 0, sectionCount: 0)
  ];

  void generateProjectCards() {
    for (Project project in projectsList) {
      List<Task> tasks = List.from(tasksList);
      tasks =
          tasks.where((element) => element.projectId == project.id).toList();

      listOfProjectCards.add(ProjectCardModel(
        projectData: project,
        taskCount: tasks.length, sectionCount: sectionList.where((element) => element.projectId == project.id).toList().length),
      );
    }
    listOfProjectCards.removeWhere((element)=>element.projectData.id==LanguageService.getString.id);
    setState();
  }

  Future<void> deleteProject({required String projectId}) async {
    final dashboardProvider =
        StateService.context.read(ProviderService.dashboardProvider);
    AppPopups.showLoader();
    await locator<NetworkService>().deleteProjectById(projectId: projectId);
    callDispose();
    await dashboardProvider.refresh();
    StateService.pop();
  }

  Future<void> projectFavouriteToggle(
      {required String projectId, required bool isFavourite}) async {
    final dashboardProvider =
        StateService.context.read(ProviderService.dashboardProvider);
    AppPopups.showLoader();
    await locator<NetworkService>().updateAProjectById(
        projectId: projectId, requestBody: {LanguageService.getString.isfavorite: "${!isFavourite}"});
    callDispose();
    await dashboardProvider.refresh();
    StateService.pop();
  }

  @override
  void callDispose() {
    listOfProjectCards = [
      ProjectCardModel(
          projectData: Project(
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
          taskCount: 0, sectionCount: 0)
    ];
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
