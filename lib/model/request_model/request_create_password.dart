
class RequestCreatePassword{

  String userid;
  String password;
  String conf_password;

  RequestCreatePassword({this.userid,this.password,this.conf_password});

  Map<String,dynamic> tojson() => {
    'userid':this.userid,
    'newpassword':this.password,
  };

}