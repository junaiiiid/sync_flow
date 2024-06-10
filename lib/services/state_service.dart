import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/home/ui/home_screen.dart';

class StateService {
  StateService._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentState!.context;

  static void pushNamed({required String routeName}){
    context.push(routeName);
  }

  static void pop(){
    context.pop();
  }

  static void navigateAfterSplash(){
    context.go(HomeScreen.id);
  }

  static ChangeNotifierProvider<T> createProvider<T extends ChangeNotifier>(
      T Function() create) {
    return ChangeNotifierProvider<T>((ref) => create());
  }
}