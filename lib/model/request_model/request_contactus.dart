
class RequestContactUs{

   String name;
   String email;
   String message;

  RequestContactUs({this.email,this.name,this.message});

  Map<String,dynamic> tojson() => {
    'a':this.name,
    'b':this.email,
    'c':this.message,
  };

}