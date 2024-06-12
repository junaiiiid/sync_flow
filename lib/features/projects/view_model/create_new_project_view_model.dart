import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import '../../board/model/section_model.dart';

class CreateNewProjectViewModel extends BaseViewModel{

  late Project project;
  late List<Section> sections;

  @override
  void callDispose() {
    // TODO: implement callDispose
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }

}