class LoginDetails {
  String _url;
  String _username;
  String password;

  String get url => _url?.trim();

  set url(String url) {
    _url = url;
  }

  String get username => _username?.trim();

  set username(String username) {
    _username = username;
  }

  LoginDetails({String url, String username, this.password})
      : _url = url,
        _username = username;
}
