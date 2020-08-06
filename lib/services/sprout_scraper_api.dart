import 'dart:convert';

import 'package:sprout_app/models/biologs.dart';
import 'package:http/http.dart' as http;
import 'package:sprout_app/models/login_details.dart';

Future<Biologs> requestTimein(LoginDetails details) async {
  final http.Response response = await http.post(
    'http://192.168.1.9:3000/timein',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'url': details.url,
      'username': details.username,
      'password': details.password,
    }),
  );

  if (response.statusCode == 200) {
    return Biologs.fromJson(json.decode(response.body));
  } else {
    var errorMessage = "Failed to request";

    if (response.body != null && response.body.isNotEmpty) {
      var resBody = json.decode(response.body);
      if (resBody != null && resBody.containsKey("errorMessage")) {
        errorMessage = resBody["errorMessage"];
      }
    }

    throw errorMessage;
  }
}

Future<Biologs> requestTimeout(LoginDetails details) async {
  final http.Response response = await http.post(
    'http://192.168.1.9:3000/timeout',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'url': details.url,
      'username': details.username,
      'password': details.password,
    }),
  );

  if (response.statusCode == 200) {
    return Biologs.fromJson(json.decode(response.body));
  } else {
    var errorMessage = "Failed to request";

    if (response.body != null && response.body.isNotEmpty) {
      var resBody = json.decode(response.body);
      if (resBody != null && resBody.containsKey("errorMessage")) {
        errorMessage = resBody["errorMessage"];
      }
    }

    throw errorMessage;
  }
}

Future<Biologs> getBiologs(LoginDetails details) async {
  final http.Response response = await http.post(
    'http://192.168.1.9:3000/biologs',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'url': details.url,
      'username': details.username,
      'password': details.password,
    }),
  );

  if (response.statusCode == 200) {
    return Biologs.fromJson(json.decode(response.body));
  } else {
    var errorMessage = "Failed to request";

    if (response.body != null && response.body.isNotEmpty) {
      var resBody = json.decode(response.body);
      if (resBody != null && resBody.containsKey("errorMessage")) {
        errorMessage = resBody["errorMessage"];
      }
    }

    throw errorMessage;
  }
}

Future<bool> checkServer() async {
  try {
    final http.Response response =
        await http.get('http://192.168.1.9:3000/ping');

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (err) {
    return false;
  }
}
