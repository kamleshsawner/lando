
class RequestSignup{

   String name;
   String email;
   String password;
   String mobile;
   String dob;
   String gender;

  RequestSignup({this.email,this.name,this.password,this.mobile,this.dob,this.gender});

  Map<String,dynamic> tojson() => {
    'name':this.name,
    'email':this.email,
    'phone':this.mobile,
    'password':this.password,
    'dob':this.dob,
    'gender':this.gender,
  };

}