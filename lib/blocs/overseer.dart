import 'package:sprout_app/blocs/biologs_manager.dart';
import 'package:sprout_app/blocs/login_details_manager.dart';

class Overseer {
  Map<dynamic, dynamic> repository = {};

  Overseer() {
    register(BiologsManager, BiologsManager());
    register(LoginDetailsManager, LoginDetailsManager());
  }

  register(name, object) {
    repository[name] = object;
  }

  fetch(name) => repository[name];
}
