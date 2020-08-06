import 'package:flutter/material.dart';
import 'package:sprout_app/blocs/login_details_manager.dart';
import 'package:sprout_app/blocs/provider.dart';
import 'package:sprout_app/screens/main/components/form_stream_field.dart';

class FormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginDetailsManager manager =
        Provider.of(context).fetch(LoginDetailsManager);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: FormStreamField(
              label: "URL",
              icon: Icons.link,
              dispatch: manager.inUrl.add,
              subscribe: manager.url,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: FormStreamField(
              label: "Username",
              icon: Icons.person,
              dispatch: manager.inUsername.add,
              subscribe: manager.username,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: FormStreamField(
              label: "Password",
              icon: Icons.lock,
              isSensitive: true,
              dispatch: manager.inPassword.add,
              subscribe: manager.password,
            ),
          ),
        ],
      ),
    );
  }
}
