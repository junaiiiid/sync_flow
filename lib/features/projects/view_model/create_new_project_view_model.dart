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
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../../../services/dependency_injection/locator.dart';
import '../../../services/language_service.dart';
import '../../board/model/section_model.dart';
import '../model/project_section_model.dart';

class CreateNewProjectViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  Project project = Project(
      id: LanguageService.getString.id,
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
        sectionTitle: LanguageService.getString.createDefaultSections),
    ProjectSectionModel(
        sectionType: SectionType.fromLabels,
        sectionTitle: LanguageService.getString.createSectionsFromLabels),
  ];

  List<Section> defaultSections = [
    Section(projectId: LanguageService.getString.projectid, order: 1, name: LanguageService.getString.todo),
    Section(projectId: LanguageService.getString.projectid, order: 2, name: LanguageService.getString.inprogress),
    Section(projectId: LanguageService.getString.projectid, order: 3, name: LanguageService.getString.completed),
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
    LanguageService.getString.berryred,
    LanguageService.getString.red,
    LanguageService.getString.orange,
    LanguageService.getString.yellow,
    LanguageService.getString.olivegreen,
    LanguageService.getString.limegreen,
    LanguageService.getString.green,
    LanguageService.getString.mintgreen,
    LanguageService.getString.teal,
    LanguageService.getString.skyblue,
    LanguageService.getString.lightblue,
    LanguageService.getString.blue,
    LanguageService.getString.grape,
    LanguageService.getString.violet,
    LanguageService.getString.lavender,
    LanguageService.getString.magenta,
    LanguageService.getString.salmon,
    LanguageService.getString.charcoal,
    LanguageService.getString.grey,
    LanguageService.getString.taupe,
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
          type: SnackBarTypes.error, content: LanguageService.getString.theFieldsCanNotBeEmpty);
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
    callDispose();
  }

  @override
  void callDispose() {
    project = Project(
        id: LanguageService.getString.id,
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
    //_selectedColor = null;
    defaultSections = [
      Section(projectId: LanguageService.getString.projectid, order: 1, name: LanguageService.getString.todo),
      Section(projectId: LanguageService.getString.projectid, order: 2, name: LanguageService.getString.inprogress),
      Section(projectId: LanguageService.getString.projectid, order: 3, name: LanguageService.getString.completed),
    ];
    listOfProjectSections = [
      ProjectSectionModel(
          sectionType: SectionType.defaultSections,
          sectionTitle: LanguageService.getString.createDefaultSections),
      ProjectSectionModel(
          sectionType: SectionType.fromLabels,
          sectionTitle: LanguageService.getString.createSectionsFromLabels),
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
