import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprout_app/models/login_details.dart';

class LoginDetailsManager {
  LoginDetailsManager() {
    init();
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    inUrl.add(prefs.getString('sprout_url'));
    inUsername.add(prefs.getString('sprout_username'));
    inPassword.add(prefs.getString('sprout_password'));
  }

  final _url = BehaviorSubject<String>();
  Sink<String> get inUrl => _url.sink;
  Stream<String> get url => _url.stream;

  final _username = BehaviorSubject<String>();
  Sink<String> get inUsername => _username.sink;
  Stream<String> get username => _username.stream;

  final _password = BehaviorSubject<String>();
  Sink<String> get inPassword => _password.sink;
  Stream<String> get password => _password.stream;

  getLoginDetails() {
    String url = _url.value;
    String username = _username.value;
    String password = _password.value;

    return LoginDetails(
      url: url,
      username: username,
      password: password,
    );
  }

  void dispose() {
    _url.close();
    _username.close();
    _password.close();
  }
}
