

import 'package:lando/model/user.dart';

class ResponseMyProfile{

  int status;
  String message;
  User user;
  List<Gallery> gallery_list;
  List<QuestionAnswer> qus_ans_list;

  ResponseMyProfile({this.status,this.message,this.user,this.gallery_list,this.qus_ans_list});

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

class QuestionAnswer {

  final int id;
  final String question;
  String answer;

  QuestionAnswer({this.id,this.question,this.answer});

  factory QuestionAnswer.fromjson(Map<String,dynamic> json){
    return QuestionAnswer(
        id: json['id'],
        question: json['title'],
        answer: json['answer']
    );
  }

}