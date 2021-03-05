
class RequestLogin{

   String email;
   String password;
   String device_token;

  RequestLogin({this.email,this.password,this.device_token});

  Map<String,dynamic> tojson() => {
    'email':this.email,
    'password':this.password,
    'device_token':this.device_token,
  };

}