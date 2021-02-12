
class RequestSignup{

   String name;
   String email;
   String password;
   String mobile;

  RequestSignup({this.email,this.name,this.password,this.mobile});

  Map<String,dynamic> tojson() => {
    'name':this.name,
    'email':this.email,
    'phone':this.mobile,
    'password':this.password,
  };

}