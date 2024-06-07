import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/enums.dart';

import '../model/navigation_bar_model.dart';

class HomeViewModel extends BaseViewModel {
  List<NavigationBarModel> navigationBarItems = [
    NavigationBarModel(
        isActive: true, type: NavigationBarItems.home, icon: AppAssets.home, label: 'Home'),
    NavigationBarModel(
        isActive: false, type: NavigationBarItems.board, icon: AppAssets.board, label: 'Board'),
    NavigationBarModel(
        isActive: false,
        type: NavigationBarItems.projects,
        icon: AppAssets.projects, label: 'Projects'),
    NavigationBarModel(
        isActive: false,
        type: NavigationBarItems.settings,
        icon: AppAssets.settings, label: 'Settings'),
  ];

  NavigationBarModel _selectedItem = NavigationBarModel(
      isActive: true, type: NavigationBarItems.home, icon: AppAssets.home, label: 'Home');

  NavigationBarModel get selectedItem => _selectedItem;

  set selectedItem(NavigationBarModel value) {
    _selectedItem = value;
    for(NavigationBarModel element in navigationBarItems){
      if(element==_selectedItem){
        element.isActive = true;
      }
      else{
        element.isActive = false;
      }
    }
    notifyListeners();
  }

  @override
  void callDispose() {
    // TODO: implement callDispose
  }

  @override
  void callInitState() {
    _selectedItem = navigationBarItems.first;
  }
}
