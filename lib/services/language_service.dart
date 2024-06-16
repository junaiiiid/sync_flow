import 'package:flow_sync/generated/l10n.dart';
import 'package:flow_sync/services/state_service.dart';

class LanguageService{

  static S get getString => S.of(StateService.context);

}