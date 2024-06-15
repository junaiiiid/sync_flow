import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/cupertino.dart';

import '../../../constants/enums.dart';
import '../../../global_widgets/app_popups.dart';

class CreateNewTaskViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  String? sectionId;

  String? projectId;

  List<Label> get listOfLabels =>
      StateService.context.read(ProviderService.dashboardProvider).listOfLabels;

  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController labelController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();

  @override
  void callDispose() {
    taskTitleController.clear();
    taskDescriptionController.clear();
    labelController.clear();
    dueDateController.clear();
    sectionId = null;
  }

  Future<void> createNewTask() async {
    final dashBoardProvider =
        StateService.context.read(ProviderService.dashboardProvider);
    final boardProvider =
    StateService.context.read(ProviderService.boardProvider);
    StateService.context.read(ProviderService.dashboardProvider);
    if (formKey.currentState?.validate() ?? false) {
      AppPopups.showLoader();
      final Task taskModel = Task(
          projectId: projectId!,
          content: taskTitleController.text,
          description: taskDescriptionController.text,
          labels: [labelController.text],
          sectionId: sectionId,
          due: dueDateController.text,
          createdAt: DateTime.now());
      final Task? newTask =
          await locator<NetworkService>().createATask(requestBody: {
        "project_id": taskModel.projectId,
        "section_id": taskModel.sectionId,
        "content": taskModel.content,
        "labels": taskModel.labels,
        "description": taskModel.description,
        "due": taskModel.due!.toDateTime().toIso8601WithMillis(),
        "created_at": taskModel.createdAt.toIso8601WithMillis(),
      });
      if (newTask != null) {
        dashBoardProvider.listOfTasks.add(newTask);
      }
      boardProvider.selectedProject = boardProvider.selectedProject;
      setState();
      callDispose();
      StateService.pop();
    } else {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "The fields can not be empty.");
    }
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
