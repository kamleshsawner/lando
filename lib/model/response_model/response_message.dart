
import 'package:lando/util/mystrings.dart';

class ResponseMessage{

  int status;
  String message;

  ResponseMessage({this.status,this.message});

  factory ResponseMessage.fromjson(Map<String,dynamic> json, int status){
    try{
      return ResponseMessage(status: status,message: json['message']);
    }catch(_){
      return ResponseMessage(status: status,message: MyString.ERROR_MESSAGE);
    }
  }

  factory ResponseMessage.fromjsonforstatus(Map<String,dynamic> json, int status){
    try{
      return ResponseMessage(status:  json['status'],message: json['message']);
    }catch(_){
      return ResponseMessage(status: status,message: MyString.ERROR_MESSAGE);
    }
  }

}