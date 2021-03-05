
class RequestSocialLogin{

   String name;
   String email;
   String social_type;
   String social_id;
   String device_token;

  RequestSocialLogin({this.email,this.name,this.social_type,this.social_id,this.device_token});

  Map<String,dynamic> tojson() => {
    'name':this.name,
    'email':this.email,
    'social_type':this.social_type,
    'social_id':this.social_id,
    'device_token':this.device_token,
  };

}