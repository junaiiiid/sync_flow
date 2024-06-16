import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
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
      List<String> labels = [labelController.text,sectionId??''];
      final Task taskModel = Task(
          projectId: projectId??'',
          content: taskTitleController.text,
          description: taskDescriptionController.text,
          labels: labels,
          sectionId: sectionId??'',
          due: dueDateController.text.toDateTime().toString(),
          createdAt: DateTime.now());
      final Task? newTask =
          await locator<NetworkService>().createATask(requestBody: {
        LanguageService.getString.projectid: taskModel.projectId,
        LanguageService.getString.sectionid: taskModel.sectionId,
        LanguageService.getString.content: taskModel.content,
        LanguageService.getString.labels: taskModel.labels,
        LanguageService.getString.description: taskModel.description,
        LanguageService.getString.duedate: taskModel.due,
        LanguageService.getString.createdat: taskModel.createdAt.toIso8601WithMillis(),
      });
      if (newTask != null) {
        Task? updatedLabelsTask = await locator<NetworkService>().updateATaskById(taskId: newTask.id!, requestBody: {
          'labels':labels
        });
        if(updatedLabelsTask!=null){
          dashBoardProvider.listOfTasks.add(updatedLabelsTask);
        }
      }
      boardProvider.selectedProject = boardProvider.selectedProject;
      setState();
      callDispose();
      StateService.pop();
    } else {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: LanguageService.getString.theFieldsCanNotBeEmpty);
    }
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
