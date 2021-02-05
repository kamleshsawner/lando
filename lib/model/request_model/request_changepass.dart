
class RequestChangePass{

   String old_pass;
   String new_pass;
   String conf_password;

  RequestChangePass({this.new_pass,this.old_pass,this.conf_password});

  Map<String,dynamic> tojson() => {
    'o':this.old_pass,
    'n':this.new_pass,
    'c':this.conf_password,
  };

}