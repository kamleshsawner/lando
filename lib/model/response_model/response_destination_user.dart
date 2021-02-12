import 'package:flutter/material.dart';
import 'package:lando/util/myassets.dart';

class ResponseDestinationUsers{

  int status;
  String message;
  List<DestinationUser> user_list;

  ResponseDestinationUsers({this.status,this.message,this.user_list});

}

class DestinationUser{

  int id;
  String name;
  String image;

  DestinationUser({this.id,this.name,this.image});

  factory DestinationUser.fromjson(Map<String,dynamic> json){
    return DestinationUser(
      id: json['id'],
      name: json['name'],
      image : json['profile'],
    );
  }

}


class VenueUserAdapterView extends StatelessWidget{

  final DestinationUser selected_friend;
  final Function onPressed;

  const VenueUserAdapterView({Key key, this.selected_friend,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
        ),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                selected_friend.image == '' ? ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.asset(
                    MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE,
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.fill,
                  ),
                ) :
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(selected_friend.image,),
                          fit: BoxFit.fill)),
                ),
                SizedBox(width: 20,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '${selected_friend.name}',style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          height: 10,width: 10,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.green),
                        )
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

}