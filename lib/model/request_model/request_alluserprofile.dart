
class RequestAallUserProfile{

   String userid;
   String group_id;

  RequestAallUserProfile({this.userid,this.group_id});

  Map<String,dynamic> tojson() => {
    'userid':this.userid,
    'group_id':this.group_id,
  };


}