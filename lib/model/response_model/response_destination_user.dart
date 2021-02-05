
class ResponseDestination{

  int status;
  String message;
  List<User> user_list;

  ResponseDestination({this.status,this.message,this.user_list});

  factory ResponseDestination.fromjson(Map<String,dynamic> json,int status){
    if(status == 200){

      var list_array = json['data'] as List;
      List<User> list = list_array.map((e) => User.fromjson(e));

      return ResponseDestination(
          status: status,
          message: json['message'],
          user_list:list
      );
    }else{
      return ResponseDestination(
          status: status,
          message: json['message'],
          user_list:null
      );
    }
  }

}

class User{

  int id;
  String name;
  String image;

  User({this.id,this.name,this.image});

  factory User.fromjson(Map<String,dynamic> json){
    return User(
      id: json[''],
      name: json[''],
      image : json[''],
    );
  }

}