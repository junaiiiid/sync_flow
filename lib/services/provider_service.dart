import 'package:flow_sync/features/board/view_model/board_view_model.dart';
import 'package:flow_sync/features/comments/view_model/comment_view_model.dart';
import 'package:flow_sync/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:flow_sync/features/home/view_model/home_view_model.dart';
import 'package:flow_sync/features/labels/view_model/labels_view_model.dart';
import 'package:flow_sync/features/projects/view_model/project_view_model.dart';
import 'package:flow_sync/features/settings/view_model/settings_view_model.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}
