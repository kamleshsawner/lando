

import 'package:lando/model/user.dart';

class ResponseMyProfile{

  int status;
  String message;
  User user;
  List<Gallery> gallery_list;

  ResponseMyProfile({this.status,this.message,this.user,this.gallery_list});

}


class Gallery {

  final int id;
  final String image;

  Gallery({this.id,this.image});

  factory Gallery.fromjson(Map<String,dynamic> json){
    return Gallery(
        id: json['id'],
      image: json['image']
    );
  }

}