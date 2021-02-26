import 'package:flutter/material.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/util/myassets.dart';

class ResponseDestination{

  int status;
  String message;
  List<Destination> dest_list;

  ResponseDestination({this.status,this.message,this.dest_list});
}

class Destination{

  int id;
  String title;
  String image;
  int status;

  Destination({this.id,this.title,this.image,this.status});

  factory Destination.fromjson(Map<String,dynamic> json){
    return Destination(
      id: json['id'],
      title: json['title'],
      image : APIServices.BASE_PROFILE_IMAGE_URL+json['group_image'],
      status: json['is_joined'],
    );
  }

}


class DestinationAdapterView extends StatelessWidget{

  final Destination selected_destination;
  final double height;
  final Function onPressed;

  const DestinationAdapterView({Key key, this.selected_destination,@required this.height,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width/2.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  image: NetworkImage(selected_destination.image),
                  placeholder: AssetImage(MyAssets.ASSET_IMAGE_LOGO),
                  height: height-80,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width/2.2,
                )
            ),),
            Container(
              child: Flexible(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  child: Text(selected_destination.title, style: TextStyle(fontSize: 14,color: Colors.black)),),
              ),
            ),
          ],
        ),
      ),
    );
  }

}