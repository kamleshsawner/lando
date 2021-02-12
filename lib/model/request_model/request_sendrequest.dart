
class RequestSendRequest{

   String user_id;
   String sendto;

  RequestSendRequest({this.sendto,this.user_id});

  Map<String,dynamic> tojson() => {
    'userid':this.user_id,
    'send_to':this.sendto,
  };

}