import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/section_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/services/dependency_injection/locator_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';

import '../model/tabs_model.dart';

class BoardViewModel extends BaseViewModel {
  List<Section> listOfSections = [];

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

  Future<void> getSectionsOfSelectedProject() async {
    listOfSections = [];
    final networkService = LocatorService.networkServiceLocator;
    listOfSections = await networkService.getAllSectionsOfProjectById(
        projectId: selectedProject.id);
    notifyListeners();
  }

  List<TabsModel> getTabModel() {
    List<TabsModel> tabsModel = [];
    for (Section section in listOfSections) {
      String sectionName = section.name.toLowerCase();
      if (sectionName.contains("to") || sectionName.contains("do")) {
        tabsModel
            .add(TabsModel(tabName: section.name, iconPath: AppAssets.todo));
      } else if (sectionName.contains("progress")) {
        tabsModel
            .add(TabsModel(tabName: section.name, iconPath: AppAssets.inProgress));
      }
      else if (sectionName.contains("complete")){
        tabsModel.add(TabsModel(tabName: section.name, iconPath: AppAssets.completed));
      }
      else{
        tabsModel.add(TabsModel(tabName: section.name, iconPath: AppAssets.section));
      }
    }
    return tabsModel;
  }

  @override
  void callDispose() {
    // TODO: implement callDispose
  }

  @override
  void callInitState() {}
}
