import 'package:flutter/material.dart';
import 'package:sprout_app/screens/main/components/flat_link_button.dart';
import 'package:sprout_app/screens/main/components/round_button.dart';
import 'package:sprout_app/services/sprout_scraper_api.dart';

class ButtonsContainer extends StatelessWidget {
  final List<Map<dynamic, dynamic>> _roundButtons = [
    {"label": "TIME IN", "icon": Icons.timer, "action": requestTimein},
    {"label": "TIME OUT", "icon": Icons.timer_off, "action": requestTimeout}
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildRoundButtons(),
        ),
        FlatLinkButton(),
      ],
    );
  }

  List<Widget> _buildRoundButtons() {
    List<Widget> roundButtons = [];
    for (var button in _roundButtons) {
      roundButtons.add(RoundButton(
          label: button["label"],
          icon: button["icon"],
          action: button["action"]));
    }
    return roundButtons;
  }
}
