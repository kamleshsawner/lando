
class RequestContactUs{

   String name;
   String email;
   String message;

  RequestContactUs({this.email,this.name,this.message});

  Map<String,dynamic> tojson() => {
    'name':this.name,
    'email':this.email,
    'message':this.message,
  };

}