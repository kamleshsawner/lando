
class RequestForgot{

  String email;

  RequestForgot({this.email});

  Map<String,dynamic> tojson() => {
    'email':this.email,
  };

}