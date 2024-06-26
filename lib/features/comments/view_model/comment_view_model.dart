import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
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
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/enums.dart';
import '../../dashboard/model/comment_model.dart';
import '../../dashboard/model/project_model.dart';

class CommentViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  TextEditingController commentController = TextEditingController();

  List<Comment> allComments = [
    Comment(
        id: LanguageService.getString.id,
        taskId: LanguageService.getString.taskid,
        content: LanguageService.getString.content,
        postedAt: DateTime.now(),
        projectId: '')
  ];

  List<Task> get listOfTasks =>
      StateService.context.read(ProviderService.dashboardProvider).listOfTasks;

  List<Project> get listOfProjects => StateService.context
      .read(ProviderService.dashboardProvider)
      .listOfProjects;

  Project getProjectByTaskId({required String id}) {
    Task task = getTaskById(id: id);
    List<Project> allProjects = List.from(listOfProjects);
    Project filteredProject =
        allProjects.firstWhere((element) => element.id == task.projectId);
    return filteredProject;
  }

  Task getTaskById({required String id}) {
    List<Task> allTasks = List.from(listOfTasks);
    Task filteredTasks = allTasks.firstWhere((element) => element.id == id);
    return filteredTasks;
  }

  Project getProjectById({required String id}) {
    List<Project> allProjects = List.from(listOfProjects);
    Project filteredProject =
        allProjects.firstWhere((element) => element.id == id);
    return filteredProject;
  }

  Future<void> openAttachment({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception(LanguageService.getString.couldNotLaunchUrl);
    }
  }

  Future<void> editComment({required String id}) async {
    if (formKey.currentState?.validate() ?? false) {
      StateService.pop();
      AppPopups.showLoader();
      await locator<NetworkService>()
          .updateACommentById(commentId: id, requestBody: {
        "content": commentController.text,
        "posted_at":
            DateTime.now().toIso8601WithMillis(),
      });
      await refresh();
      StateService.pop();
    } else {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error,
          content: LanguageService.getString.commentCanNotBeEmpty);
    }
  }

  Future<void> deleteComment({required String id}) async {
    AppPopups.showLoader();
    await locator<NetworkService>().deleteACommentById(commentId: id);
    await refresh();
    StateService.pop();
    setState();
  }

  @override
  Future<void> refresh() async {
    callDispose();
    await initialize();
  }

  @override
  void callDispose() {
    allComments = [
      Comment(
          id: LanguageService.getString.id,
          taskId: LanguageService.getString.taskid,
          content: LanguageService.getString.content,
          postedAt: DateTime.now(),
          projectId: '')
    ];
    commentController.clear();
  }

  @override
  void callInitState() {
    initialize();
  }

  Future<void> initialize() async {
    for (Task task in listOfTasks) {
      List<Comment> comments =
          await locator<NetworkService>().getCommentByTaskId(taskId: task.id!);
      allComments.addAll(comments);
    }
    for (Project project in listOfProjects) {
      List<Comment> comments = await locator<NetworkService>()
          .getCommentByProjectId(projectId: project.id);
      allComments.addAll(comments);
    }
    allComments
        .removeWhere((element) => element.id == LanguageService.getString.id);
    setState();
  }
}
