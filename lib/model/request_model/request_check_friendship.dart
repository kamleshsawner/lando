
class RequestCheckFriendship{

   String userid;
   String action_userid;

  RequestCheckFriendship({this.userid,this.action_userid});

  Map<String,dynamic> tojson() => {
    'action_userid':this.action_userid,
    'userid':this.userid,
  };

}