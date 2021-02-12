
class RequestToken{

   String user_id;

  RequestToken({this.user_id});

  Map<String,dynamic> tojson_id() => {
    'id':this.user_id,
  };

  Map<String,dynamic> tojson_userid() => {
    'userid':this.user_id,
  };

}