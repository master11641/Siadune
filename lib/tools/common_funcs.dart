import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void showAlert(BuildContext context, String input) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the that user has entered by using the
          // TextEditingController.
          content: Text(input),
        );
      });
}

void showSnackBar(BuildContext context, String input,
    [Color backgroundColor = Colors.greenAccent]) {
  final snackBar = SnackBar(
    duration: Duration(seconds: 5),
    content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            '$input',
            style: TextStyle(fontSize: 25.0),
          ),
        )),
    backgroundColor: backgroundColor,
  );
  Scaffold.of(context).showSnackBar(snackBar);
}

getAndroidDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  print(androidInfo.device);
}

get_iOS_DeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
  print(iosDeviceInfo.model);
}

saveAurhenticatedCookie(String cookieValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('my-very-own-cookie-name', cookieValue);
}

Future<String> getAuthenticateCookie() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('my-very-own-cookie-name')) {
    return prefs.getString('my-very-own-cookie-name');
  }
  return '';
}

Future<Map<String, String>> getAuthenticateHeader() async {
  Map<String, String> headers = {};
  String cookie = await getAuthenticateCookie();
  if (cookie.length != 0) {
    headers['cookie'] = 'my-very-own-cookie-name=$cookie;';
  }
  return headers;
}
