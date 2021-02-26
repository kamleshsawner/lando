
class RequestSocialLogin{

   String name;
   String email;
   String social_type;
   String social_id;

  RequestSocialLogin({this.email,this.name,this.social_type,this.social_id});

  Map<String,dynamic> tojson() => {
    'name':this.name,
    'email':this.email,
    'social_type':this.social_type,
    'social_id':this.social_id,
  };

}