import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/material.dart';

import '../../../constants/enums.dart';
import '../../../global_widgets/app_popups.dart';
import '../../../services/dependency_injection/locator.dart';
import '../../dashboard/model/project_model.dart';

class AddCommentViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  final TextEditingController commentController = TextEditingController();

  List<Project> get listOfProjects => StateService.context.read(ProviderService.dashboardProvider).listOfProjects;

  List<Task> _listOfTasks = [];

  List<Task> get listOfTasks => _listOfTasks;

  set listOfTasks(List<Task> value) {
    _listOfTasks = value;
    notifyListeners();
  }

  Project? _selectedProject;

  Project? get selectedProject => _selectedProject;

  set selectedProject(Project? value) {
    _selectedProject = value;
    _filterListOfTasks();
    setState();
  }

  Task? _selectedTask;

  Task? get selectedTask => _selectedTask;

  set selectedTask(Task? value) {
    _selectedTask = value;
    setState();
  }

  Future<void> addAComment() async{
    final commentProvider = StateService.context.read(ProviderService.commentProvider);
    if(formKey.currentState?.validate() ?? false){
      AppPopups.showLoader();
      await locator<NetworkService>().createAComment(requestBody: {
        "content":commentController.text,
        if (selectedTask != null) "task_id": selectedTask!.id,
        if (selectedProject != null) "project_id": selectedProject!.id,
      });
      await commentProvider.refresh();
      callDispose();
      StateService.pop();
    }
    else{
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "The fields can not be empty.");
    }
  }

  void _filterListOfTasks(){
    _listOfTasks = StateService.context.read(ProviderService.dashboardProvider).listOfTasks;
    List<Task> filteredTasks = [];
    for(Task task in listOfTasks){
      if(task.projectId == selectedProject?.id){
        filteredTasks.add(task);
      }
    }
    listOfTasks = filteredTasks;
  }

  @override
  void callDispose() {
    _listOfTasks = [];
    commentController.clear();
    _selectedProject = null;
    _selectedTask = null;
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
