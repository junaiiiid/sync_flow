import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flutter/material.dart';

import '../model/extras_item_model.dart';
import '../model/navigation_bar_model.dart';

class HomeViewModel extends BaseViewModel {
  final DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  void toggleExtraWidget() {
    isExtrasOpened = !isExtrasOpened;
    double value = _isExtrasOpened ? 0.65 : 0;
    draggableScrollableController.animateTo(
      value,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  bool _isExtrasOpened = false;

  bool get isExtrasOpened => _isExtrasOpened;

  set isExtrasOpened(bool value) {
    _isExtrasOpened = value;
    setState();
  }

  List<NavigationBarModel> navigationBarItems = [
    NavigationBarModel(
        isActive: true,
        type: NavigationBarItems.home,
        icon: AppAssets.home,
        label: LanguageService.getString.home),
    NavigationBarModel(
        isActive: false,
        type: NavigationBarItems.board,
        icon: AppAssets.board,
        label: LanguageService.getString.board),
    NavigationBarModel(
        isActive: false,
        type: NavigationBarItems.projects,
        icon: AppAssets.projects,
        label: LanguageService.getString.projects),
    NavigationBarModel(
        isActive: false,
        type: NavigationBarItems.settings,
        icon: AppAssets.settings,
        label: LanguageService.getString.settings),
  ];

  NavigationBarModel _selectedItem = NavigationBarModel(
      isActive: true,
      type: NavigationBarItems.home,
      icon: AppAssets.home,
      label: LanguageService.getString.home);

  NavigationBarModel get selectedItem => _selectedItem;

  set selectedItem(NavigationBarModel value) {
    _selectedItem = value;
    for (NavigationBarModel element in navigationBarItems) {
      if (element == _selectedItem) {
        element.isActive = true;
      } else {
        element.isActive = false;
      }
    }
    setState();
  }

  List<ExtrasItemModel> extrasMenuItems = [
    ExtrasItemModel(
        title: LanguageService.getString.todo,
        subtitle: LanguageService.getString.viewAllTheTasksYouHaveToStart,
        iconPath: AppAssets.todo,
        path: "/todo"),
    ExtrasItemModel(
        title: LanguageService.getString.inprogress,
        subtitle: LanguageService.getString.viewAllTheTasksYouAreWorkingOn,
        iconPath: AppAssets.inProgress,
        path: "/in-progress"),
    ExtrasItemModel(
        title: LanguageService.getString.completed,
        subtitle: LanguageService.getString.viewAllTheTasksYouHaveCompleted,
        iconPath: AppAssets.completed,
        path: "/completed"),
  ];

  @override
  void callDispose() {
    _isExtrasOpened = false;
    navigationBarItems = [
      NavigationBarModel(
          isActive: true,
          type: NavigationBarItems.home,
          icon: AppAssets.home,
          label: LanguageService.getString.home),
      NavigationBarModel(
          isActive: false,
          type: NavigationBarItems.board,
          icon: AppAssets.board,
          label: LanguageService.getString.board),
      NavigationBarModel(
          isActive: false,
          type: NavigationBarItems.projects,
          icon: AppAssets.projects,
          label: LanguageService.getString.projects),
      NavigationBarModel(
          isActive: false,
          type: NavigationBarItems.settings,
          icon: AppAssets.settings,
          label: LanguageService.getString.settings),
    ];
    _selectedItem = NavigationBarModel(
        isActive: true,
        type: NavigationBarItems.home,
        icon: AppAssets.home,
        label: LanguageService.getString.home);
    extrasMenuItems = [
      ExtrasItemModel(
          title: LanguageService.getString.todo,
          subtitle: LanguageService.getString.viewAllTheTasksYouHaveToStart,
          iconPath: AppAssets.todo,
          path: "/todo"),
      ExtrasItemModel(
          title: LanguageService.getString.inprogress,
          subtitle: LanguageService.getString.viewAllTheTasksYouAreWorkingOn,
          iconPath: AppAssets.inProgress,
          path: "/in-progress"),
      ExtrasItemModel(
          title: LanguageService.getString.completed,
          subtitle: LanguageService.getString.viewAllTheTasksYouHaveCompleted,
          iconPath: AppAssets.completed,
          path: "/completed"),
    ];
    draggableScrollableController.dispose();
  }

  @override
  void callInitState() {
    _selectedItem = navigationBarItems.first;
    draggableScrollableController.addListener((){
      if(draggableScrollableController.size == 0){
        isExtrasOpened = false;
      }
    });
  }
}
