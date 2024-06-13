import 'package:flow_sync/features/comments/ui/comments_screen.dart';
import 'package:flow_sync/features/labels/ui/create_new_label_screen.dart';
import 'package:flow_sync/features/labels/ui/labels_screen.dart';
import 'package:flow_sync/features/projects/ui/create_projects_screen.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../features/home/ui/home_screen.dart';
import '../features/splash/ui/splash_screen.dart';
class RouteService {
  RouteService._();

  static GoRouter router = GoRouter(
    navigatorKey: StateService.navigatorKey,
    routes: [
      RouteNames.getRoute(
          routeName: SplashScreen.id, page: const SplashScreen()),
      RouteNames.getRoute(
          routeName: HomeScreen.id, page: const HomeScreen()),
      RouteNames.getRoute(
          routeName: CommentsScreen.id, page: const CommentsScreen()),
      RouteNames.getRoute(
          routeName: LabelsScreen.id, page: const LabelsScreen()),
      RouteNames.getRoute(
          routeName: CreateProjectsScreen.id, page: const CreateProjectsScreen()),
      RouteNames.getRoute(
          routeName: CreateNewLabelScreen.id, page: const CreateNewLabelScreen()),
    ],
  );
}

class RouteNames {
  RouteNames._();

  static GoRoute getRoute({required String routeName, required Widget page}) {
    return GoRoute(
      path: routeName,
      builder: (context, state) => page,
    );
  }
}