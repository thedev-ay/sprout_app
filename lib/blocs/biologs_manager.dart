import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprout_app/models/biologs.dart';
import 'package:sprout_app/utilities/datetime_util.dart';

class BiologsManager {
  final BehaviorSubject<Biologs> _response = BehaviorSubject<Biologs>();
  StreamSink<Biologs> get request => _response.sink;
  Stream<Biologs> get response => _response.stream;

  BiologsManager() {
    response.listen((data) {
      if (data != null) {
        _cacheBiologs(data);
      }
    });
  }

  void _cacheBiologs(Biologs data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(
        "biologs_expiration",
        DateTime.parse(DateTimeUtil.getLastMinuteOfTheDay())
            .millisecondsSinceEpoch);
    prefs.setString("timein", data.timein);
    prefs.setString("timeout", data.timeout);
    prefs.setString("timediff", data.timediff);
    prefs.setString("lastupdated", data.lastupdated);
  }

  void initFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int biologsExpiration = prefs.getInt("biologs_expiration") ?? 0;

    Biologs initialBiologs = Biologs();

    if (new DateTime.now().millisecondsSinceEpoch < biologsExpiration) {
      var timein = prefs.getString("timein");
      var timeout = prefs.getString("timeout");
      var timediff = prefs.getString("timediff");
      var lastupdated = prefs.getString("lastupdated");

      initialBiologs = Biologs(
        timein: timein,
        timeout: timeout,
        timediff: timediff,
        lastupdated: lastupdated,
      );
    }

    request.add(initialBiologs);
  }

  void dispose() {
    _response.close();
  }
}
