import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/global_widgets/app_popups.dart';
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../services/dependency_injection/locator.dart';
import '../../board/model/section_model.dart';
import '../model/project_section_model.dart';

class CreateNewProjectViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  Project project = Project(
      id: "id",
      order: 0,
      color: "",
      name: "",
      commentCount: 0,
      isShared: false,
      isFavorite: false,
      isInboxProject: false,
      isTeamInbox: false,
      url: "",
      viewStyle: "");

  List<ProjectSectionModel> listOfProjectSections = [
    ProjectSectionModel(
        sectionType: SectionType.defaultSections,
        sectionTitle: "Create Default Sections"),
    ProjectSectionModel(
        sectionType: SectionType.fromLabels,
        sectionTitle: "Create Sections From Labels"),
  ];

  List<Section> defaultSections = [
    Section(projectId: 'projectId', order: 1, name: "TO-DO"),
    Section(projectId: 'projectId', order: 2, name: "IN-PROGRESS"),
    Section(projectId: 'projectId', order: 3, name: "COMPLETED"),
  ];

  List<Section> sectionsFromLabels = [];

  List<Label> selectedLabels = [];

  late ProjectSectionModel _selectedSection;

  ProjectSectionModel get selectedSection => _selectedSection;

  set selectedSection(ProjectSectionModel value) {
    _selectedSection = value;
    setState();
  }

  final TextEditingController projectNameController = TextEditingController();

  String? _selectedColor;

  String? get selectedColor => _selectedColor;

  set selectedColor(String? value) {
    _selectedColor = value;
    setState();
  }

  final List<String> colorNames = [
    'berry_red',
    'red',
    'orange',
    'yellow',
    'olive_green',
    'lime_green',
    'green',
    'mint_green',
    'teal',
    'sky_blue',
    'light_blue',
    'blue',
    'grape',
    'violet',
    'lavender',
    'magenta',
    'salmon',
    'charcoal',
    'grey',
    'taupe',
  ];

  Future<void> createNewProject() async {
    final dashboardProvider =
        StateService.context.read(ProviderService.dashboardProvider);
    final projectProvider =
        StateService.context.read(ProviderService.projectProvider);
    if (formKey.currentState?.validate() ?? false) {
      AppPopups.showLoader();
      project.color = selectedColor ?? "";
      project.name = projectNameController.text;
      project.viewStyle = ViewStyles.board.toShortString();
      final Project? newProject = await locator<NetworkService>()
          .createNewProject(projectModel: project);
      await createSections(projectId: newProject?.id ?? '');
      projectProvider.callDispose();
      await dashboardProvider.refresh();
      StateService.pop();
      callDispose();
    } else {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "The fields can not be empty.");
    }
  }

  Future<void> createSections({required String projectId}) async {
    late List<Section> sectionList;
    switch (selectedSection.sectionType) {
      case SectionType.defaultSections:
        sectionList = defaultSections;
        for (Section section in sectionList) {
          section.projectId = projectId;
        }
      case SectionType.fromLabels:
        for (Label label in selectedLabels) {
          sectionsFromLabels.add(
            Section(
                projectId: projectId,
                order: selectedLabels.indexOf(label) + 1,
                name: label.name,
                id: label.id),
          );
        }
        sectionList = sectionsFromLabels;
    }
    _selectedSection = listOfProjectSections.first;
    for(Section section in sectionList){
      await locator<NetworkService>().createNewSection(sectionModel: section);
    }
    dispose();
  }

  @override
  void callDispose() {
    project = Project(
        id: "id",
        order: 0,
        color: "",
        name: "",
        commentCount: 0,
        isShared: false,
        isFavorite: false,
        isInboxProject: false,
        isTeamInbox: false,
        url: "",
        viewStyle: "");
    projectNameController.clear();
    _selectedColor = null;
    defaultSections = [
      Section(projectId: 'projectId', order: 1, name: "TO-DO"),
      Section(projectId: 'projectId', order: 2, name: "IN-PROGRESS"),
      Section(projectId: 'projectId', order: 3, name: "COMPLETED"),
    ];
    listOfProjectSections = [
      ProjectSectionModel(
          sectionType: SectionType.defaultSections,
          sectionTitle: "Create Default Sections"),
      ProjectSectionModel(
          sectionType: SectionType.fromLabels,
          sectionTitle: "Create Sections From Labels"),
    ];
    sectionsFromLabels = [];
    selectedLabels = [];
    _selectedSection = listOfProjectSections.first;
  }

  @override
  void callInitState() {
    _selectedSection = listOfProjectSections.first;
  }
}
