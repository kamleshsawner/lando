
import 'package:lando/model/response_model/response_myprofile.dart';
import 'package:lando/model/response_model/response_send_request.dart';
import 'package:lando/util/mystrings.dart';

class ResponseAllProfile{

  int status;
  String message;
  List<UserProfile> list_profiles;

  ResponseAllProfile({this.status,this.message,this.list_profiles});

}

class UserProfile {

  final int user_id;
  final String image;
  final String name;
  final String gender;
  final String chat_id;
  List<QuestionAnswer> list_ques_ans;
  List<Gallery> gallery_list;

  UserProfile({this.user_id,this.image,this.name,this.gender,this.list_ques_ans,this.gallery_list,this.chat_id});

  factory UserProfile.fromjson(Map<String,dynamic> json){

    List<QuestionAnswer> quesans_list = null;
    var ques_list_array = json['questions'] as List;
    if(ques_list_array.length>0){
      quesans_list = ques_list_array.map((myobject) => QuestionAnswer.fromjson(myobject)).toList();
    }

    List<Gallery> gallery_list = null;
    var gallery_array = json['gallery'] as List;
    if(gallery_array.length>0){
      gallery_list = gallery_array.map((myobject) => Gallery.fromjson(myobject)).toList();
    }

    return UserProfile(
        user_id: json['id'],
        image: json['profile'],
        name: json['name'],
      gender: json['gender'],
      chat_id: json['firebase_chatid'],
      list_ques_ans: quesans_list,
      gallery_list: gallery_list,
    );
  }

}