
class RequestSignup{

   String name;
   String email;
   String password;
   String mobile;

  RequestSignup({this.email,this.name,this.password,this.mobile});

  Map<String,dynamic> tojson() => {
    '':this.name,
    '':this.email,
    '':this.mobile,
    '':this.password,
  };

}