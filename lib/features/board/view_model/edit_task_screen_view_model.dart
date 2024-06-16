import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/section_model.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
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
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/enums.dart';
import '../../../global_widgets/app_popups.dart';
import '../../dashboard/model/comment_model.dart';
import '../../dashboard/model/task_model.dart';

class EditTaskScreenViewModel extends BaseViewModel {
  final taskFormKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
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
        id: LanguageService.getString.id,
        projectId: LanguageService.getString.projectid,
        content: LanguageService.getString.content,
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

  Future<void> openAttachment({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception(LanguageService.getString.couldNotLaunchUrl);
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
    if (taskFormKey.currentState?.validate() ?? false) {
      Task? updatedTask = await locator<NetworkService>().updateATaskById(
        taskId: taskId,
        requestBody: {
          LanguageService.getString.sectionid: selectedSection?.id,
          LanguageService.getString.content: taskTitleController.text,
          LanguageService.getString.description: taskDescriptionController.text,
          LanguageService.getString.labels: labels,
          LanguageService.getString.duedate: dateTimeFormat,
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
          type: SnackBarTypes.error, content: LanguageService.getString.theFieldsCanNotBeEmpty);
    }
    StateService.context.pop();
  }

  Future<void> getAllCommentsByTaskId({required String taskId}) async {
    List<Comment> comments = await locator<NetworkService>().getCommentByTaskId(taskId: taskId);
    allComments = comments;
    setState();
  }

  Future<void> editComment({required String id}) async{
    if(formKey.currentState?.validate()??false){
      StateService.pop();
      AppPopups.showLoader();
      final Comment? editedComment = await locator<NetworkService>().updateACommentById(commentId: id, requestBody: {
        LanguageService.getString.content: commentController.text,
        LanguageService.getString.postedat: DateTime.now().toIso8601WithMillis(),
      });
      if(editedComment!=null){
        allComments.removeWhere((element)=>element.id==id);
        allComments.add(editedComment);
      }
      setState();
      StateService.pop();
    }else{
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: LanguageService.getString.commentCanNotBeEmpty);
    }
  }

  Future<void> deleteComment({required String id}) async{
    AppPopups.showLoader();
    await locator<NetworkService>().deleteACommentById(commentId: id);
    allComments.removeWhere((element)=>element.id==id);
    StateService.pop();
    setState();
  }

  Future<void> addAComment() async{
    if(formKey.currentState?.validate() ?? false){
      AppPopups.showLoader();
      final Comment? newComment = await locator<NetworkService>().createAComment(requestBody: {
        LanguageService.getString.content:commentController.text,
        LanguageService.getString.taskid: taskModel?.id??'',
        LanguageService.getString.projectid: taskModel?.projectId??'',
      });
      if(newComment!=null){
        allComments.add(newComment);
        commentController.clear();
      }
      setState();
      StateService.pop();
    }
    else{
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: LanguageService.getString.theFieldsCanNotBeEmpty);
    }
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
    allComments = [
      Comment(
          id: LanguageService.getString.id,
          projectId: LanguageService.getString.projectid,
          content: LanguageService.getString.content,
          postedAt: DateTime.now())
    ];
    commentController.clear();
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
