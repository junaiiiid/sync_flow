import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/enums.dart';
import '../../../global_widgets/app_popups.dart';
import '../../../services/dependency_injection/locator.dart';
import '../../../services/dependency_injection/locator_service.dart';
import '../../../services/network_service.dart';
import '../../board/model/section_model.dart';
import '../../board/model/tabs_model.dart';
import '../../dashboard/model/comment_model.dart';
import '../../dashboard/model/task_model.dart';

class ProjectDetailsViewModel extends BaseViewModel{

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

  List<Task> get tasksList => StateService.context.read(ProviderService.dashboardProvider).listOfTasks;

  List<Section> listOfSections = [
    Section(id: "id", projectId: "projectId", order: 0, name: "name")
  ];

  List<Comment> allComments = [
    Comment(
        id: "id",
        projectId: "projectId",
        content: "content",
        postedAt: DateTime.now())
  ];

  final formKey = GlobalKey<FormState>();

  final TextEditingController commentController = TextEditingController();

  void initialize({required Project project}) async{
      _selectedProject = project;
      await getSectionsOfSelectedProject();
      await getAllCommentsByProjectId();
  }

  Future<void> getAllCommentsByProjectId() async {
    List<Comment> comments = await locator<NetworkService>().getCommentByProjectId(projectId: selectedProject.id);
    allComments = comments;
    setState();
  }

  Future<void> editComment({required String id}) async{
    if(formKey.currentState?.validate()??false){
      StateService.pop();
      AppPopups.showLoader();
      final Comment? editedComment = await locator<NetworkService>().updateACommentById(commentId: id, requestBody: {
        "content": commentController.text,
        "posted_at": DateTime.now().toIso8601WithMillis(),
      });
      if(editedComment!=null){
        allComments.removeWhere((element)=>element.id==id);
        allComments.add(editedComment);
      }
      setState();
      StateService.pop();
    }else{
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "Comment can not be empty.");
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
        "content":commentController.text,
        "project_id": selectedProject.id,
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
          type: SnackBarTypes.error, content: "The fields can not be empty.");
    }
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
  void callInitState() {
    // TODO: implement callInitState
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
    StateService.context.pop();
  }

  Future<void> getSectionsOfSelectedProject() async {
    final networkService = LocatorService.networkServiceLocator;
    listOfSections = await networkService.getAllSectionsOfProjectById(
        projectId: selectedProject?.id ?? "");
    if (listOfSections.isNotEmpty) {
      listOfSections.removeWhere((element) => element.id == "id");
    }
    setState();
  }

}