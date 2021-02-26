
import 'package:lando/model/response_model/response_myprofile.dart';
import 'package:lando/util/mystrings.dart';

class ResponseSendRequest{

  int status;
  String message;
  List<QuestionAnswer> list_ques_ans;
  List<UserGallery> gallery_list;

  ResponseSendRequest({this.status,this.message,this.list_ques_ans,this.gallery_list});

}

class UserGallery {

  final int user_id;
  final String image;

  UserGallery({this.user_id,this.image});

  factory UserGallery.fromjson(Map<String,dynamic> json){
    return UserGallery(
        user_id: json['user_id'],
        image: json['image'],
    );
  }

}