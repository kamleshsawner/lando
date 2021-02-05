
class ResponseDestination{

  int status;
  String message;
  List<Destination> dest_list;

  ResponseDestination({this.status,this.message,this.dest_list});

  factory ResponseDestination.fromjson(Map<String,dynamic> json,int status){
    if(status == 200){

      var list_array = json['data'] as List;
      List<Destination> list = list_array.map((e) => Destination.fromjson(e));

      return ResponseDestination(
          status: status,
          message: json['message'],
          dest_list:list
      );
    }else{
      return ResponseDestination(
          status: status,
          message: json['message'],
          dest_list:null
      );
    }
  }

}

class Destination{

  int id;
  String name;
  String image;

  Destination({this.id,this.name,this.image});

  factory Destination.fromjson(Map<String,dynamic> json){
    return Destination(
      id: json[''],
      name: json[''],
      image : json[''],
    );
  }

}