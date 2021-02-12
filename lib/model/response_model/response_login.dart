

import 'package:lando/model/user.dart';

class ResponseLogin{

  int status;
  String message;
  User user;

  ResponseLogin({this.status,this.message,this.user});

  factory ResponseLogin.fromjson(Map<String,dynamic> json,int status){
    if(status == 200){
      return ResponseLogin(
          status: status,
          message: json['message'],
          user:User.fromjson(json['users'])
      );
    }else{
      return ResponseLogin(
          status: status,
          message: json['message'],
          user:null
      );
    }
  }

}