import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprout_app/blocs/biologs_manager.dart';
import 'package:sprout_app/blocs/login_details_manager.dart';
import 'package:sprout_app/blocs/provider.dart';
import 'package:sprout_app/models/login_details.dart';
import 'package:sprout_app/screens/response/response_screen.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key key,
    @required this.action,
    @required this.label,
    @required this.icon,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final Function action;

  @override
  Widget build(BuildContext context) {
    BiologsManager biologsManager = Provider.of(context).fetch(BiologsManager);
    LoginDetailsManager loginDetailsManager =
        Provider.of(context).fetch(LoginDetailsManager);

    return Container(
      width: 100,
      height: 100,
      child: MaterialButton(
        autofocus: false,
        shape: CircleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 25.0,
              color: Theme.of(context).primaryColorDark,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
        color: Colors.green[100],
        textColor: Colors.black54,
        onPressed: () async {
          LoginDetails details = loginDetailsManager.getLoginDetails();

          action(details)
              .then((value) => biologsManager.request.add(value))
              .catchError((error) => biologsManager.request.addError(error));

          await cacheDetails(details);

          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) =>
                  new ResponseScreen(isRequested: true)));
        },
      ),
    );
  }

  Future cacheDetails(details) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("sprout_url", details.url);
    prefs.setString("sprout_username", details.username);
    prefs.setString("sprout_password", details.password);
  }
}
