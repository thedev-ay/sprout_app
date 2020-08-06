import 'package:sprout_app/utilities/datetime_util.dart';

class Biologs {
  String timein;
  String timeout;
  String timediff;
  String lastupdated;

  Biologs({this.timein, this.timeout, this.timediff, this.lastupdated});

  factory Biologs.fromJson(Map<String, dynamic> json) {
    return Biologs(
      timein: json['timein'],
      timeout: json['timeout'],
      timediff: json['timediff'] is double
          ? json['timediff'].toStringAsFixed(2)
          : json['timediff'],
      lastupdated: DateTimeUtil.getCurrentTime(),
    );
  }
}
