import 'package:flow_sync/features/board/ui/edit_task_screen.dart';
import 'package:flow_sync/features/comments/ui/add_comment_screen.dart';
import 'package:flow_sync/features/comments/ui/comments_screen.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/features/labels/ui/create_new_label_screen.dart';
import 'package:flow_sync/features/labels/ui/labels_screen.dart';
import 'package:flow_sync/features/notifications/ui/notification_screen.dart';
import 'package:flow_sync/features/projects/ui/create_projects_screen.dart';
import 'package:flow_sync/features/projects/ui/project_detailed_screen.dart';
import 'package:flow_sync/features/task_timer/model/timer_task_model.dart';
import 'package:flow_sync/features/task_timer/ui/task_timer_screen.dart';
import 'package:flow_sync/features/task_timer/ui/widgets/individual_task_timer_screen.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../features/board/ui/create_task_screen.dart';
import '../features/home/ui/home_screen.dart';
import '../features/splash/ui/splash_screen.dart';

class RouteService {
  RouteService._();

  static Map<String, Widget Function(BuildContext)> routeNames = {
    SplashScreen.id : (context)=> const SplashScreen(),
    HomeScreen.id : (context)=> const HomeScreen(),
    CommentsScreen.id:(context)=> const CommentsScreen(),
    LabelsScreen.id:(context)=> const LabelsScreen(),
    CreateProjectsScreen.id:(context)=> const CreateProjectsScreen(),
    CreateNewLabelScreen.id:(context)=> const CreateNewLabelScreen(),
    AddCommentScreen.id:(context)=> const AddCommentScreen(),
    NotificationScreen.id:(context)=>const NotificationScreen(),
    TaskTimerScreen.id:(context)=>const TaskTimerScreen(),

  };

/*  static GoRouter router = GoRouter(
    navigatorKey: StateService.navigatorKey,
    routes: [
      RouteNames.getRoute(
          routeName: SplashScreen.id, page: const SplashScreen()),
      RouteNames.getRoute(routeName: HomeScreen.id, page: const HomeScreen()),
      RouteNames.getRoute(
          routeName: CommentsScreen.id, page: const CommentsScreen()),
      RouteNames.getRoute(
          routeName: LabelsScreen.id, page: const LabelsScreen()),
      RouteNames.getRoute(
          routeName: CreateProjectsScreen.id,
          page: const CreateProjectsScreen()),
      RouteNames.getRoute(
          routeName: CreateNewLabelScreen.id,
          page: const CreateNewLabelScreen()),
      RouteNames.getRoute(
          routeName: AddCommentScreen.id, page: const AddCommentScreen()),
      RouteNames.getRoute(
          routeName: NotificationScreen.id, page: const NotificationScreen()),
      RouteNames.getRoute(
          routeName: TaskTimerScreen.id, page: const TaskTimerScreen()),
      GoRoute(
        path: CreateTaskScreen.id,
        builder: (context, state) {
          final sectionId = state.extra as String;
          return CreateTaskScreen(sectionId: sectionId);
        },
      ),
      GoRoute(
        path: EditTaskScreen.id,
        builder: (context, state) {
          final taskModel = state.extra as Task;
          return EditTaskScreen(taskModel: taskModel);
        },
      ),
      GoRoute(
        path: ProjectDetailedScreen.id,
        builder: (context, state) {
          final projectModel = state.extra as Project;
          return ProjectDetailedScreen(
            model: projectModel,
          );
        },
      ),
      GoRoute(
        path: IndividualTaskTimerScreen.id,
        builder: (context, state) {
          final model = state.extra as TimerTaskModel;
          return IndividualTaskTimerScreen(
            model: model,
          );
        },
      ),
    ],
  );*/
}

class RouteNames {
/*  RouteNames._();
  static GoRoute getRoute({required String routeName, required Widget page}) {
    return GoRoute(
      path: routeName,
      builder: (context, state) => page,
    );
  }

  static MaterialPageRoute getMaterialRoute({required Widget page}) {
    return MaterialPageRoute(
      builder: (context) => page,
    );
  }*/
}
