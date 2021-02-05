
class RequestForgot{

  String mobile;

  RequestForgot({this.mobile});

  Map<String,dynamic> tojson() => {
    '':this.mobile,
  };

}