import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/util/myassets.dart';

class FriendRequest {

  final int id;
  final String name;
  final String image;
  final String age;
  final String city;

  FriendRequest({this.id,this.name,this.image,this.age,this.city});

  static List<FriendRequest> getriendrequestList(){
    var list = List<FriendRequest>();
    list.add(FriendRequest(id: 1,name: 'Jully',image: MyAssets.ASSET_ICON_NAV_PROFILE,city: 'London',age: '28'));
    list.add(FriendRequest(id: 2,name: 'Nick',image: MyAssets.ASSET_ICON_NAV_PROFILE,city: 'London',age: '27'));
    list.add(FriendRequest(id: 1,name: 'John',image: MyAssets.ASSET_ICON_NAV_PROFILE,city: 'London',age: '34'));
    list.add(FriendRequest(id: 2,name: 'Merry',image: MyAssets.ASSET_ICON_NAV_PROFILE,city: 'London',age: '32'));
    return list;
  }
}


class FirendRequestAdapterView extends StatelessWidget{

  final FriendRequest selected_friend;
  const FirendRequestAdapterView({Key key, this.selected_friend}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.asset(
                  MyAssets.ASSET_IMAGE_DUMMY_PROFILE,
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 10,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '${selected_friend.name} , ${selected_friend.age}',style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 10,width: 10,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.green),
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(
                    selected_friend.city,style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  )
                ],
              )),
              Container(
                padding: EdgeInsets.fromLTRB(10,8,10,8),
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(7)
                ),
                  child: Text('Accept',style: TextStyle(color: Colors.white,fontSize: 14),)),
              SizedBox(width: 15,),
              Container(
                  margin: EdgeInsets.only(right: 25),
                  child: Icon(Icons.cancel_outlined,color: Colors.white,))
            ],
          ),
          SizedBox(height: 5,),
          Container(color: Colors.white,height: 1,)
        ],
      ),
    );
  }

}