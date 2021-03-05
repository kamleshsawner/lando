
class RequestSignup{

   String name;
   String email;
   String password;
   String mobile;
   String dob;
   String gender;
   String device_token;

  RequestSignup({this.email,this.name,this.password,this.mobile,this.dob,this.gender,this.device_token});

  Map<String,dynamic> tojson() => {
    'name':this.name,
    'email':this.email,
    'phone':this.mobile,
    'password':this.password,
    'dob':this.dob,
    'gender':this.gender,
    'device_token':this.device_token,
  };

}