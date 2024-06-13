import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/enums.dart';
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
        label: 'Home'),
    NavigationBarModel(
        isActive: false,
        type: NavigationBarItems.board,
        icon: AppAssets.board,
        label: 'Board'),
    NavigationBarModel(
        isActive: false,
        type: NavigationBarItems.projects,
        icon: AppAssets.projects,
        label: 'Projects'),
    NavigationBarModel(
        isActive: false,
        type: NavigationBarItems.settings,
        icon: AppAssets.settings,
        label: 'Settings'),
  ];

  NavigationBarModel _selectedItem = NavigationBarModel(
      isActive: true,
      type: NavigationBarItems.home,
      icon: AppAssets.home,
      label: 'Home');

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
        title: "TO-DO",
        subtitle: "View all the tasks you have to start.",
        iconPath: AppAssets.todo,
        path: "/todo"),
    ExtrasItemModel(
        title: "IN-PROGRESS",
        subtitle: "View all the tasks you are working on.",
        iconPath: AppAssets.inProgress,
        path: "/in-progress"),
    ExtrasItemModel(
        title: "COMPLETED",
        subtitle: "View all the tasks you have completed.",
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
          label: 'Home'),
      NavigationBarModel(
          isActive: false,
          type: NavigationBarItems.board,
          icon: AppAssets.board,
          label: 'Board'),
      NavigationBarModel(
          isActive: false,
          type: NavigationBarItems.projects,
          icon: AppAssets.projects,
          label: 'Projects'),
      NavigationBarModel(
          isActive: false,
          type: NavigationBarItems.settings,
          icon: AppAssets.settings,
          label: 'Settings'),
    ];
    _selectedItem = NavigationBarModel(
        isActive: true,
        type: NavigationBarItems.home,
        icon: AppAssets.home,
        label: 'Home');
    extrasMenuItems = [
      ExtrasItemModel(
          title: "TO-DO",
          subtitle: "View all the tasks you have to start.",
          iconPath: AppAssets.todo,
          path: "/todo"),
      ExtrasItemModel(
          title: "IN-PROGRESS",
          subtitle: "View all the tasks you are working on.",
          iconPath: AppAssets.inProgress,
          path: "/in-progress"),
      ExtrasItemModel(
          title: "COMPLETED",
          subtitle: "View all the tasks you have completed.",
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
