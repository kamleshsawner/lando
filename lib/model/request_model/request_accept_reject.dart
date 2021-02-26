
class RequestAcceptReject{

   String status;
   String id;

  RequestAcceptReject({this.id,this.status});

  Map<String,dynamic> tojson() => {
    'status':this.status,
    'id':this.id,
  };


  Map<String,dynamic> tojsondummy() => {
    'status':this.status,
    'id':this.id,
  };

}