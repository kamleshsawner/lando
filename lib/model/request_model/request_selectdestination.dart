
class RequestSelectDestination{

   String user_id;
   String destination_id;

  RequestSelectDestination({this.destination_id,this.user_id});

  Map<String,dynamic> tojson() => {
    'userid':this.user_id,
    'groupid':this.destination_id,
  };

}