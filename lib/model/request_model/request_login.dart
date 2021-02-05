
class RequestLogin{

   String email;
   String password;

  RequestLogin({this.email,this.password});

  Map<String,dynamic> tojson() => {
    'email':this.email,
    'password':this.password,
  };

}