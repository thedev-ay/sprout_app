import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            child: Text(
              "SPROUT",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text(
              "ATTENDANCE",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ],
      ),
    );
  }
}
