
class RequestChangePass{

   String user_id;
   String old_pass;
   String new_pass;
   String conf_password;

  RequestChangePass({this.new_pass,this.old_pass,this.conf_password,this.user_id});

  Map<String,dynamic> tojson() => {
    'user_id':this.user_id,
    'old_password':this.old_pass,
    'password':this.new_pass,
    'confirm_password':this.conf_password,
  };

}