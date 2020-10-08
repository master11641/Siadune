import 'dart:io';

import 'package:siadune/models/authenticate_result.dart';

import '../api/base_api.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:siadune/model/model.dart' as model;
import '../models/login_result.dart';
import '../models/success_message.dart';
import '../models/user.dart';
import '../tools/common_funcs.dart';
import '../tools/network_service.dart';
import '../pages/home_page.dart';

class AccountApi extends BaseApi {
  Future<AuthenticateResult> register(
      {String username, String password, String fcmToken, String name}) async {
    String uri = BaseApi.registerUrl;
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'Name': '$name',
      'Username': '$username',
      'Password': '$password',
      'FcmToken': '$fcmToken',
    };
    final encoding = Encoding.getByName('utf-8');
    var result = AuthenticateResult.fromJson(
        await networkService.post(uri, body: body, encoding: encoding));
    return result;
  }

  Future<LoginResult> login({String username, String password}) async {
    String uri = BaseApi.loginUrl;
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'email': '$username',
      'password': '$password',
      'rememberme': 'true'
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    var result = LoginResult.fromJson(
        await networkService.post(uri, body: body, encoding: encoding));
    networkService.cookies.forEach((key, value) {
      if (key == 'my-very-own-cookie-name') {
        saveAurhenticatedCookie(value);
      }
    });
    return result;
  } //login method

  Future<User> getUser() async {
    var user = await model.User().select().toSingle();
    var url = '${BaseApi.currentUserUrl}';
    final headers = await getAuthenticateHeader();
    headers.addAll({HttpHeaders.authorizationHeader: 'Bearer ${user.token}'});
    http.Response response = await http.get(url, headers: headers);
    if ((response.statusCode < 200 ||
        response.statusCode > 400 ||
        json == null)) {
      throw new Exception("Error while fetching data");
    }
    // if(response.statusCode==403){
    //      return User(name: 'کاربر ناشناس',family: '',imageUser: '',imageUserBase64: '');
    // }
    return User.fromJson(json.decode(response.body));
  }

  Future<SuccessMessage> updateUserClimes(
      {String imageUser, String name, String family}) async {
    var url = '${BaseApi.updateUserClimesUrl}';
    final headers = await getAuthenticateHeader();
    headers.addAll({'Content-Type': 'application/json'});
    Map<String, dynamic> body = {
      'ImageUser': '$imageUser',
      'Name': '$name',
      'Family': '$family',
      'PushNotificationToken': pushMessagingToken,
    };
    http.Response response = await http.post(url,
        headers: headers,
        body: json.encode(body),
        encoding: Encoding.getByName('utf-8'));
    if ((response.statusCode < 200 ||
            response.statusCode > 400 ||
            json == null) &&
        response.statusCode != 403) {
      throw new Exception("Error while fetching data");
    }
    return SuccessMessage.fromJson(json.decode(response.body));
  }

  Future<LoginCheckResult> loginCheck({String mobileNumber}) async {
    var uri = BaseApi.loginCheckUrl;
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {'mobileNumber': '$mobileNumber'};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    if (response.statusCode == 200) {
      return LoginCheckResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  } //login method

}

AccountApi accountApi = new AccountApi();
