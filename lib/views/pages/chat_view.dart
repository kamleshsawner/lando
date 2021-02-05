import 'package:flutter/material.dart';
import 'package:lando/model/friend_request.dart';
import 'package:lando/model/friends.dart';
import 'package:lando/model/venue_users.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/views/pages/send_request_view.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

  var _scaffold_key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: MyColors.COLOR_STATUS_BAR,
      ),
      key: _scaffold_key,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_DARK,MyColors.COLOR_PRIMARY_LIGHT],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 55,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,size: 25),
                    color: Colors.white,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.asset(
                      MyAssets.ASSET_IMAGE_DUMMY_PROFILE,
                      width: 45.0,
                      height: 45.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SendRequestView()
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('John',style: TextStyle(color: Colors.white,fontSize: 18),),
                          Text('online',style: TextStyle(color: Colors.white,fontSize: 12),)
                        ],
                      ),
                    ),
                  )),
                  IconButton(
                    icon: Icon(Icons.menu,size: 25),
                    color: Colors.white,
                    onPressed: (){
                      _menuOption();
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.white,
              margin: EdgeInsets.only(top: 55),
            ),
          ],
        ),
      ),
    );
  }

  void _menuOption(){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder){
          return Container(
            height: 320,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Center(child: Text('Select Option',style: TextStyle(color: Colors.black,fontSize: 16),),)),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Center(child: Text('Clear All Chat',style: TextStyle(color: Colors.black,fontSize: 16),),)),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Center(child: Text('Report User',style: TextStyle(color: Colors.black,fontSize: 16),),)),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Center(child: Text('Block User',style: TextStyle(color: Colors.red,fontSize: 16),),)),
                    ],
                  ),
                ),
                Container(height: 15,color: Colors.transparent,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                        padding: EdgeInsets.all(15),
                        child: Center(child: Text('Cancel',style: TextStyle(color: Colors.red,fontSize: 16),),)),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }


}
