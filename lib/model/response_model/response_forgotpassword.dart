
import 'package:lando/util/mystrings.dart';

class ResponseForgotPassword{
  
  int status;
  String message;
  int userid;
  String otp;

  ResponseForgotPassword({this.status,this.message,this.userid,this.otp});

  factory ResponseForgotPassword.fromjson(Map<String,dynamic> json, int status){
    if(status == 200){
    try{
      return ResponseForgotPassword(status: status,message: json['message'],otp: json['otp'].toString(),userid: json['userid']);
       }catch(_){
      return ResponseForgotPassword(status: status,message: MyString.ERROR_MESSAGE,userid: null,otp: null);
     }
    }else{
      return ResponseForgotPassword(status: status,message: json['message'],userid: null,otp: null);
    }
  }

}

