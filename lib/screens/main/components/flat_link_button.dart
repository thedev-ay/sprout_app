import 'package:flutter/material.dart';
import 'package:sprout_app/blocs/login_details_manager.dart';
import 'package:sprout_app/blocs/provider.dart';
import 'package:sprout_app/screens/response/response_screen.dart';

class FlatLinkButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginDetailsManager loginDetailsManager =
        Provider.of(context).fetch(LoginDetailsManager);

    return FlatButton(
      materialTapTargetSize: MaterialTapTargetSize.padded,
      onPressed: () {
        var details = loginDetailsManager.getLoginDetails();

        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) =>
                new ResponseScreen(details: details, isRequested: false)));
      },
      child: Text(
        "View Biologs",
        style: Theme.of(context).textTheme.button.apply(color: Colors.white),
      ),
    );
  }
}
