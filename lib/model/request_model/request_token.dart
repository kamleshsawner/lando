
class RequestToken{

   String user_id;

  RequestToken({this.user_id});

  Map<String,dynamic> tojson_id() => {
    'id':this.user_id,
  };

  Map<String,dynamic> tojson_userid() => {
    'userid':this.user_id,
  };

  Map<String,dynamic> tojson_user_id() => {
    'user_id':this.user_id,
  };

}