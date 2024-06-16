import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../generated/l10n.dart';
import '../features/home/ui/home_screen.dart';

class StateService {
  StateService._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentState!.context;

  static void pushNamed({required String routeName}) {
    context.push(routeName);
  }

  static void pushNamedWithArguments<T>(
      {required String routeName, required T argument}) {
    GoRouter.of(context).push(
      routeName,
      extra: argument,
    );
  }

  static Iterable<Locale> supportedLocales = S.delegate.supportedLocales;

  static Iterable<LocalizationsDelegate<dynamic>>? localizationDelegates = [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static void pop() {
    context.pop();
  }

  static void navigateAfterSplash() {
    context.go(HomeScreen.id);
  }

  static ChangeNotifierProvider<T> createProvider<T extends ChangeNotifier>(
      T Function() create) {
    return ChangeNotifierProvider<T>((ref) => create());
  }
}
