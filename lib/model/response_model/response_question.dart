
class ResponseQuestions{

  int status;
  String message;
  List<Question> ques_list;

  ResponseQuestions({this.status,this.message,this.ques_list});

  factory ResponseQuestions.fromjson(Map<String,dynamic> json,int status){
    if(status == 200){

      var list_array = json['data'] as List;
      List<Question> list = list_array.map((e) => Question.fromjson(e));

      return ResponseQuestions(
          status: status,
          message: json['message'],
          ques_list:list
      );
    }else{
      return ResponseQuestions(
          status: status,
          message: json['message'],
          ques_list:null
      );
    }
  }

}

class Question{

  int id;
  String question;

  Question({this.id,this.question});

  factory Question.fromjson(Map<String,dynamic> json){
    return Question(
      id: json['id'],
      question: json['title'],
    );
  }

}