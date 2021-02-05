import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lando/model/request_model/request_changepass.dart';
import 'package:lando/model/request_model/request_contactus.dart';
import 'package:lando/model/request_model/request_forgot.dart';
import 'package:lando/model/request_model/request_login.dart';
import 'package:lando/model/request_model/request_signup.dart';
import 'package:lando/model/response_model/response_destination.dart';
import 'package:lando/model/response_model/response_login.dart';
import 'dart:convert';

import 'package:lando/model/response_model/response_message.dart';

class APIServices {
  static const String BASE_URL = "";

  // profile apis
  static const String API_SIGNUP = BASE_URL + '';
  static const String API_LOGIN = BASE_URL + '';
  static const String API_FORGOT = BASE_URL + '';

  // QUESTION
  static const String API_QUESTIONS = BASE_URL + '';
  static const String API_SUBMIT_ANSWER = BASE_URL + '';

  // package
  static const String API_PACKAGE = BASE_URL + '';
  static const String API_DESTINATION = BASE_URL + '';

   // other
  static const String API_CONTACT_US = BASE_URL + '';
  static const String API_CHANGE_PASSWORD = BASE_URL + '';


  // login api
  Future<ResponseLogin> userLogin(RequestLogin requestLogin) async {
    print(requestLogin.tojson().toString());
    final response = await postCall(path: API_LOGIN, parameters: requestLogin.tojson());
    print(response.body);
    return ResponseLogin.fromjson(json.decode(response.body), response.statusCode);
  }

  // signup api
  Future<ResponseLogin> userSignup(RequestSignup requestSignup) async {
    print(requestSignup.tojson().toString());
    final response = await postCall(path: API_SIGNUP, parameters: requestSignup.tojson());
    print(response.body);
    return ResponseLogin.fromjson(json.decode(response.body), response.statusCode);
  }

  // forgot api
  Future<ResponseMessage> getPassword(RequestForgot requestForgot) async {
    print(requestForgot.tojson().toString());
    final response = await postCall(path: API_FORGOT, parameters: requestForgot.tojson());
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // contact us
  Future<ResponseMessage> contactUs(RequestContactUs requestcontact,String token) async {
    print(requestcontact.tojson().toString());
    final response = await postTokenCall(path: API_CONTACT_US, parameters: requestcontact.tojson(),token: token);
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // contact us
  Future<ResponseMessage> changePassword(RequestChangePass requestchangepass,String token) async {
    print(requestchangepass.tojson().toString());
    final response = await postTokenCall(path: API_CHANGE_PASSWORD, parameters: requestchangepass.tojson(),token: token);
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // get destination
  Future<ResponseDestination> getDestination(String token) async {
    final response = await get_apirequest(path: API_DESTINATION, token: token);
    var response_data = jsonDecode(response.body);
    return ResponseDestination.fromjson(response_data,response.statusCode);
  }

  // post api request without token
  Future<http.Response> postCall(
      {@required String path,
        @required Map<String, dynamic> parameters}) async {
    final result = await http.post(path,
        headers: header(),
        encoding: Encoding.getByName("utf-8"),
        body: parameters);
    return result;
  }

  // post api request with token
  Future<http.Response> postTokenCall(
      {@required String path,
        @required Map<String, dynamic> parameters,
        @required String token}) async {
    final result = await http.post(path,
        headers: tokenHeader(token),
        encoding: Encoding.getByName("utf-8"),
        body: parameters);
    return result;
  }

  // get api request
  Future<http.Response> get_apirequest(
      {@required String path, @required String token}) async {
    final result = await http.get(
      path,
      headers: tokenHeader(token),
    );
    return result;
  }


  // api header
  Map<String, String> header() => {
    "X-Requested-With": "XMLHttpRequest",
    "Content-Type": "application/x-www-form-urlencoded"
  };

  // api token header
  Map<String, String> tokenHeader(String token) => {
    "X-Requested-With": "XMLHttpRequest",
    "Authorization": "Bearer $token",
    "Content-Type": "application/x-www-form-urlencoded"
  };

}
