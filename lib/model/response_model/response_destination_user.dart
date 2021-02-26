import 'package:flutter/material.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/utility.dart';

class ResponseDestinationUsers {
  int status;
  String message;
  List<DestinationUser> user_list;

  ResponseDestinationUsers({this.status, this.message, this.user_list});
}

class DestinationUser {
  int id;
  String name;
  String image;
  String firebase_chatid;

  DestinationUser({this.id, this.name, this.image, this.firebase_chatid});

  factory DestinationUser.fromjson(Map<String, dynamic> json) {
    return DestinationUser(
        id: json['id'],
        name: json['name'],
        image: json['profile'],
        firebase_chatid: json['firebase_chatid']);
  }
}

class VenueUserAdapterView extends StatelessWidget {
  final DestinationUser selected_friend;
  final Function onPressed;

  const VenueUserAdapterView({Key key, this.selected_friend, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: FadeInImage(
                        image: NetworkImage(Utility.getCompletePath(selected_friend.image)),
                        placeholder: AssetImage(MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE),
                        height: 60,
                        fit: BoxFit.fill,
                        width:60,
                      )
                  ),),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '${selected_friend.name}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
/*
                        Container(
                          height: 10,width: 10,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.green),
                        )
*/
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
