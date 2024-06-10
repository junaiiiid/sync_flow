import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/view_model/board_view_model.dart';
import 'package:flow_sync/features/dashboard/model/comment_model.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/dependency_injection/locator_service.dart';
import 'package:flow_sync/services/network_service.dart';

import '../../../services/provider_service.dart';
import '../../../services/state_service.dart';
import '../model/dashboard_items_model.dart';
import '../model/task_model.dart';

class DashboardViewModel extends BaseViewModel{

  List<Project> listOfProjects = [];
  List<Task> listOfTasks = [];
  List<List<Comment>> listOfComments = [];
  List<Label> listOfPersonalLabels = [];


  List<DashboardItemsModel> dashboardItems = [];

  List<DashboardItemsModel> get dashboardItemsSkeleton => [
    DashboardItemsModel(iconPath: AppAssets.allProjects, label: "Loading...", length: 0),
    DashboardItemsModel(iconPath: AppAssets.comments, label: "Loading...", length: 0),
    DashboardItemsModel(iconPath: AppAssets.personalLabels, label: "Loading...", length: 0),
    DashboardItemsModel(iconPath: AppAssets.labels, label: "Loading...", length: 0),
  ];

  @override
  void callDispose() {
    listOfProjects = [];
    listOfTasks = [];
    listOfComments = [];
    listOfPersonalLabels = [];
    dashboardItems = [];
  }

  @override
  void callInitState() {
    initialize();
  }

  Future<void> initialize() async{
    final networkService = LocatorService.networkServiceLocator;
    listOfProjects = await networkService.getAllProjects();
    listOfTasks = await networkService.getAllActiveTasks();
    for (var task in listOfTasks) {
      listOfComments.add(await networkService.getCommentByTaskId(taskId: task.id));
    }
    listOfPersonalLabels = await networkService.getAllPersonalLabels();
    int commentsLength = listOfComments.map((list) => list.length).toList().length;
    dashboardItems.add(DashboardItemsModel(iconPath: AppAssets.allProjects, label: "Total Projects", length: listOfProjects.length));
    dashboardItems.add(DashboardItemsModel(iconPath: AppAssets.comments, label: "Total Comments", length: commentsLength));
    dashboardItems.add(DashboardItemsModel(iconPath: AppAssets.labels, label: "Active Tasks", length: listOfTasks.length));
    dashboardItems.add(DashboardItemsModel(iconPath: AppAssets.personalLabels, label: "Labels", length: listOfPersonalLabels.length));
    notifyListeners();
  }

}