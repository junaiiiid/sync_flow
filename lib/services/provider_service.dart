import 'package:flow_sync/features/board/view_model/board_view_model.dart';
import 'package:flow_sync/features/board/view_model/create_new_task_view_model.dart';
import 'package:flow_sync/features/comments/view_model/add_comment_view_model.dart';
import 'package:flow_sync/features/comments/view_model/comment_view_model.dart';
import 'package:flow_sync/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:flow_sync/features/home/view_model/home_view_model.dart';
import 'package:flow_sync/features/labels/view_model/create_new_label_view_model.dart';
import 'package:flow_sync/features/labels/view_model/labels_view_model.dart';
import 'package:flow_sync/features/projects/view_model/project_details_view_model.dart';
import 'package:flow_sync/features/projects/view_model/project_view_model.dart';
import 'package:flow_sync/features/settings/view_model/settings_view_model.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/services/theme_engine_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/board/view_model/edit_task_screen_view_model.dart';
import '../features/projects/view_model/create_new_project_view_model.dart';
import '../features/splash/view_model/splash_view_model.dart';

class ProviderService {
  ProviderService._();

  static ChangeNotifierProvider<SplashViewModel> splashProvider =
      StateService.createProvider(() => SplashViewModel());

  static ChangeNotifierProvider<HomeViewModel> homeProvider =
      StateService.createProvider(() => HomeViewModel());

  static ChangeNotifierProvider<DashboardViewModel> dashboardProvider =
      StateService.createProvider(() => DashboardViewModel());

  static ChangeNotifierProvider<BoardViewModel> boardProvider =
  StateService.createProvider(() => BoardViewModel());

  static ChangeNotifierProvider<ProjectViewModel> projectProvider =
  StateService.createProvider(() => ProjectViewModel());

  static ChangeNotifierProvider<CommentViewModel> commentProvider =
  StateService.createProvider(() => CommentViewModel());

  static ChangeNotifierProvider<LabelsViewModel> labelsProvider =
  StateService.createProvider(() => LabelsViewModel());

  static ChangeNotifierProvider<SettingsViewModel> settingsProvider =
  StateService.createProvider(() => SettingsViewModel());

  static ChangeNotifierProvider<CreateNewProjectViewModel> createNewProjectProvider =
  StateService.createProvider(() => CreateNewProjectViewModel());

  static ChangeNotifierProvider<CreateNewLabelViewModel> createNewLabelProvider =
  StateService.createProvider(() => CreateNewLabelViewModel());

  static ChangeNotifierProvider<AddCommentViewModel> addCommentProvider =
  StateService.createProvider(() => AddCommentViewModel());

  static ChangeNotifierProvider<CreateNewTaskViewModel> createTaskProvider =
  StateService.createProvider(() => CreateNewTaskViewModel());

  static ChangeNotifierProvider<EditTaskScreenViewModel> editTaskProvider =
  StateService.createProvider(() => EditTaskScreenViewModel());

  static ChangeNotifierProvider<ProjectDetailsViewModel> projectDetailsProvider =
  StateService.createProvider(() => ProjectDetailsViewModel());

  static ChangeNotifierProvider<ThemeEngineService> themeEngineProvider =
  StateService.createProvider(() => ThemeEngineService());
}


