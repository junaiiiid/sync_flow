import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/comment_model.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/global_widgets/app_popups.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
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

  List<ProjectCardModel> listOfProjectCards = [];

  void generateProjectCards() {
    for (Project project in projectsList) {
      List<Task> tasks = List.from(tasksList);
      tasks =
          tasks.where((element) => element.projectId == project.id).toList();
      listOfProjectCards.add(ProjectCardModel(
        projectData: project,
        taskCount: tasks.length,
      ));
    }
    notifyListeners();
  }

  Future<void> deleteProject({required String projectId}) async{
    final dashboardProvider = StateService.context.read(ProviderService.dashboardProvider);
    AppPopups.showLoader();
    await locator<NetworkService>().deleteProjectById(projectId: projectId);
    listOfProjectCards = [];
    await dashboardProvider.refresh();
    StateService.pop();
  }



  @override
  void callDispose() {
    // TODO: implement callDispose
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
