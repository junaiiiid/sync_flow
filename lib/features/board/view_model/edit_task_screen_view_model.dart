import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/section_model.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/enums.dart';
import '../../../global_widgets/app_popups.dart';
import '../../dashboard/model/comment_model.dart';
import '../../dashboard/model/task_model.dart';

class EditTaskScreenViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  List<TextEditingController> labelControllers = [];
  List<Section> get sectionsList => StateService.context
      .read(ProviderService.dashboardProvider)
      .listOfSections;
  Label? selectedLabel;
  Section? selectedSection;
  String? dateTimeFormat;
  Task? taskModel;

  List<Comment> allComments = [
    Comment(
        id: "id",
        projectId: "projectId",
        content: "content",
        postedAt: DateTime.now())
  ];

  void initialize({required Task model}) async {
    if (taskModel == null) {
      taskModel = model;
      taskTitleController.text = taskModel?.content ?? '';
      taskDescriptionController.text = taskModel?.description ?? '';
      if (taskModel?.due is String) {
        dueDateController.text = taskModel?.due?.toFormattedDate() ?? '';
        dateTimeFormat = dueDateController.text.toDateTime().toString();
      } else if (taskModel?.due is Due) {
        final Due dueModel = taskModel?.due;
        final DateTime? object = dueModel.datetime;
        dueDateController.text = object.toString().toFormattedDate();
        dateTimeFormat = dueDateController.text.toDateTime().toString();
      } else {
        dueDateController.text = "";
      }
      for (String label in taskModel?.labels ?? []) {
        final labelController = TextEditingController();
        labelController.text = label;
        labelControllers.add(labelController);
      }
      labelControllers.removeWhere((element) => _isNumeric(element.text));
      selectedSection = sectionsList.firstWhere(
          (element) => taskModel?.labels?.contains(element.id) ?? false);
      await getAllCommentsByTaskId(taskId: model.id ?? '');
    }
  }

  // Function to check if a string is numeric
  bool _isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  Future<void> modifyTask({required String taskId}) async {
    AppPopups.showLoader();
    final dashBoardProvider =
        StateService.context.read(ProviderService.dashboardProvider);
    final boardProvider =
        StateService.context.read(ProviderService.boardProvider);
    List<String> labels =
        labelControllers.map<String>((element) => element.text).toList();
    if (selectedSection != null) {
      labels.add(selectedSection!.id!);
    }
    if (formKey.currentState?.validate() ?? false) {
      Task? updatedTask = await locator<NetworkService>().updateATaskById(
        taskId: taskId,
        requestBody: {
          "section_id": selectedSection?.id,
          "content": taskTitleController.text,
          "description": taskDescriptionController.text,
          "labels": labels,
          "due_date": dateTimeFormat,
        },
      );
      if (updatedTask != null) {
        dashBoardProvider.listOfTasks
            .removeWhere((element) => element.id == taskId);
        dashBoardProvider.listOfTasks.add(updatedTask);
        boardProvider.selectedProject = boardProvider.selectedProject;
        taskModel = updatedTask;
        setState();
      }
    } else {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "The fields can not be empty.");
    }
    StateService.context.pop();
  }

  Future<void> getAllCommentsByTaskId({required String taskId}) async {
    allComments =
        await locator<NetworkService>().getCommentByTaskId(taskId: taskId);
  }

  @override
  void callDispose() {
    taskTitleController.clear();
    taskDescriptionController.clear();
    dueDateController.clear();
    selectedLabel = null;
    selectedSection = null;
    taskModel = null;
    labelControllers = [];
    dateTimeFormat = null;
    allComments = [];
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
