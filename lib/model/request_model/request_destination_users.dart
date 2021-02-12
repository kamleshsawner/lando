
class RequestDestinationUsers{

   String group_id;

  RequestDestinationUsers({this.group_id});

  Map<String,dynamic> tojson() => {
    'groupid':this.group_id,
  };

}