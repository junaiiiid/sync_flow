import 'package:flow_sync/features/board/ui/edit_task_screen.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../generated/l10n.dart';
import '../features/home/ui/home_screen.dart';

class StateService {
  StateService._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentState!.context;

  static void pushNamed({required String routeName}) {
    Navigator.pushNamed(context, routeName);
  }

  static void pushReplacementNamed({required String routeName}) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  static Iterable<Locale> supportedLocales = S.delegate.supportedLocales;

  static Iterable<LocalizationsDelegate<dynamic>>? localizationDelegates = [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static void pop() {
    Navigator.pop(context);
  }

  static void navigateAfterSplash() {
    StateService.pushReplacementNamed(routeName: HomeScreen.id);
  }

  static ChangeNotifierProvider<T> createProvider<T extends ChangeNotifier>(
      T Function() create) {
    return ChangeNotifierProvider<T>((ref) => create());
  }
}
