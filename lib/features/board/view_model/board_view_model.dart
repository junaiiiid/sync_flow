import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';

class BoardViewModel extends BaseViewModel {
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
    notifyListeners();
  }

  List<Project> get listOfProjects => StateService.context
      .read(ProviderService.dashboardProvider)
      .listOfProjects;

  @override
  void callDispose() {
    // TODO: implement callDispose
  }

  @override
  void callInitState() {}
}
