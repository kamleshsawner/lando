import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/views/pages/chat_view.dart';

class VenueUsers {

  final int id;
  final String name;
  final String image;
  final String message;
  final String city;

  VenueUsers({this.id,this.name,this.image,this.message,this.city});

  static List<VenueUsers> getriendrequestList(){
    var list = List<VenueUsers>();
    list.add(VenueUsers(id: 1,name: 'Jully',image: MyAssets.ASSET_ICON_NAV_PROFILE,city: 'London',message: 'Hello , How are you ?'));
    list.add(VenueUsers(id: 2,name: 'Nick',image: MyAssets.ASSET_ICON_NAV_PROFILE,city: 'London',message: 'Hello , How are you ?'));
    list.add(VenueUsers(id: 1,name: 'John',image: MyAssets.ASSET_ICON_NAV_PROFILE,city: 'London',message: 'Hello , How are you ?'));
    list.add(VenueUsers(id: 2,name: 'Merry',image: MyAssets.ASSET_ICON_NAV_PROFILE,city: 'London',message: 'Hello , How are you ?'));
    return list;
  }
}


class VenueUserAdapterView extends StatelessWidget{

  final VenueUsers selected_friend;
  const VenueUserAdapterView({Key key, this.selected_friend}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatView()));
      },
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
                          '${selected_friend.name}',style: TextStyle(
                          color: Colors.black,
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
                      selected_friend.message,style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    )
                  ],
                )),
                Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.fromLTRB(10,8,10,8),
                    child: Text('15 Min Ago',style: TextStyle(color: Colors.black54,fontSize: 14),)),
              ],
            ),
          ],
        ),
      ),
    );
  }

}