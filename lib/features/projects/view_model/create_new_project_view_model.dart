import 'package:flow_sync/architecture/base_view_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import '../../board/model/section_model.dart';

class CreateNewProjectViewModel extends BaseViewModel {
  late Project project;
  late List<Section> sections;

  String? _selectedColor;

  String? get selectedColor => _selectedColor;

  set selectedColor(String? value) {
    _selectedColor = value;
    notifyListeners();
  }

  List<String> colorNames = [
    'berry_red',
    'red',
    'orange',
    'yellow',
    'olive_green',
    'lime_green',
    'green',
    'mint_green',
    'teal',
    'sky_blue',
    'light_blue',
    'blue',
    'grape',
    'violet',
    'lavender',
    'magenta',
    'salmon',
    'charcoal',
    'grey',
    'taupe',
  ];

  @override
  void callDispose() {
    // TODO: implement callDispose
  }

  @override
  void callInitState() {
    // TODO: implement callInitState
  }
}
