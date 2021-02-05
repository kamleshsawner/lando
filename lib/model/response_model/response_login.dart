

import 'package:lando/model/user.dart';

class ResponseLogin{

  int status;
  String message;
  String token;
  User user;

  ResponseLogin({this.status,this.message,this.token,this.user});

  factory ResponseLogin.fromjson(Map<String,dynamic> json,int status){
    if(status == 200){
      return ResponseLogin(
          status: status,
          message: json['message'],
          token: json['data']['token'],
          user:User.fromjson(json['data']['user'])
      );
    }else{
      return ResponseLogin(
          status: status,
          message: json['message'],
          token: null,
          user:null
      );
    }
  }

}