import 'package:flow_sync/features/dashboard/model/project_model.dart';

class ProjectCardModel {
  Project projectData;
  int sectionCount;
  int taskCount;

  ProjectCardModel(
      {required this.projectData,
      required this.taskCount,required this.sectionCount});
}
