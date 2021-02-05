import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/views/pages/chat_view.dart';

class BlockUsers {

  final int id;
  final String name;
  final String image;

  BlockUsers({this.id,this.name,this.image});

  static List<BlockUsers> getriendrequestList(){
    var list = List<BlockUsers>();
    list.add(BlockUsers(id: 1,name: 'Jully',image: MyAssets.ASSET_ICON_NAV_PROFILE,));
    list.add(BlockUsers(id: 2,name: 'Nick',image: MyAssets.ASSET_ICON_NAV_PROFILE,));
    list.add(BlockUsers(id: 3,name: 'John',image: MyAssets.ASSET_ICON_NAV_PROFILE,));
    list.add(BlockUsers(id: 4,name: 'Merry',image: MyAssets.ASSET_ICON_NAV_PROFILE,));
    return list;
  }
}


class BlockUserAdapterView extends StatelessWidget{

  final BlockUsers selected_friend;
  const BlockUserAdapterView({Key key, this.selected_friend}) : super(key: key);

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
        padding: EdgeInsets.all(10),
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
                SizedBox(width: 20,),
                Expanded(child: Text(
                  '${selected_friend.name}',style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,fontWeight: FontWeight.bold
                ),
                ),),
                Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.fromLTRB(10,8,10,8),
                    child: Text('Unblock',style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),)),
              ],
            ),
          ],
        ),
      ),
    );
  }

}