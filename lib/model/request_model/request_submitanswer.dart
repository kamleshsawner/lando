
class RequestSubmitAnswer{

   String answer;
   String ques_id;
   String user_id;

  RequestSubmitAnswer({this.user_id,this.ques_id,this.answer});

  Map<String,dynamic> tojson() => {
    'answer':this.answer,
    'question_id':this.ques_id,
    'userid':this.user_id,
  };

}