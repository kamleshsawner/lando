
class RequestForgot{

  String mobile;

  RequestForgot({this.mobile});

  Map<String,dynamic> tojson() => {
    'mobile':this.mobile,
  };

}