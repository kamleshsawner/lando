
class ResponsePackage{

  int status;
  String message;
  List<Package> dest_list;

  ResponsePackage({this.status,this.message,this.dest_list});

  factory ResponsePackage.fromjson(Map<String,dynamic> json,int status){
    if(status == 200){

      var list_array = json['data'] as List;
      List<Package> list = list_array.map((e) => Package.fromjson(e));

      return ResponsePackage(
          status: status,
          message: json['message'],
          dest_list:list
      );
    }else{
      return ResponsePackage(
          status: status,
          message: json['message'],
          dest_list:null
      );
    }
  }

}

class Package{

  int id;
  String name;
  String description;
  String price;

  Package({this.id,this.name,this.description,this.price});

  factory Package.fromjson(Map<String,dynamic> json){
    return Package(
      id: json[''],
      name: json[''],
      description : json[''],
      price : json[''],
    );
  }

}