import 'package:flow_sync/features/dashboard/model/project_model.dart';
import '../../../constants/enums.dart';

class ProjectCardModel {
  Project projectData;
  int taskCount;

  ProjectCardModel(
      {required this.projectData,
      required this.taskCount,});
}
