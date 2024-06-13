import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../dashboard/model/comment_model.dart';
import '../../dashboard/model/project_model.dart';

class CommentViewModel extends BaseViewModel {
  List<Comment> allComments = [];

  List<Task> get listOfTasks => StateService.context.read(ProviderService.dashboardProvider).listOfTasks;

  List<Project> get listOfProjects => StateService.context.read(ProviderService.dashboardProvider).listOfProjects;

  Project getProjectByTaskId({required String id}){
    Task task = getTaskById(id: id);
    List<Project> allProjects = List.from(listOfProjects);
    Project filteredProject = allProjects.firstWhere((element)=>element.id==task.projectId);
    return filteredProject;
  }

    Task getTaskById({required String id}) {
    List<Task> allTasks = List.from(listOfTasks);
    Task filteredTasks = allTasks.firstWhere((element)=>element.id==id);
    return filteredTasks;
  }

  Future<void> openAttachment({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void callDispose() {
    allComments = [];
  }

  @override
  void callInitState() {
    initialize();
  }

  Future<void> initialize() async{
    for(Task task in listOfTasks){
      List<Comment> comments = await locator<NetworkService>().getCommentByTaskId(taskId: task.id);
      allComments.addAll(comments);
    }
  }
}
