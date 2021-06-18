import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/chat/database.dart';
import 'package:lando/model/request_model/request_token.dart';
import 'package:lando/model/response_model/response_friend_req_list.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/chat_view.dart';
import 'package:lando/views/pages/friends_request_view.dart';
import 'package:lando/views/pages/home_view.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';

class FriendsView extends StatefulWidget {

  String type;
  FriendsView({this.type});

  @override
  _FriendsViewState createState() => _FriendsViewState();

}

class _FriendsViewState extends State<FriendsView> {

  var _scaffold_key = GlobalKey<ScaffoldState>();
  var is_loading = true;
  var success = 0;
  ResponseFriendReqList responsefriendrequlist;

  var loginuser_name = '';
  var mychat_id = '';
  Stream<QuerySnapshot> friends;

  @override
  void initState() {
    super.initState();
    print('my type - ' + widget.type);
    Utility().checkInternetConnection().then((internet) =>
    {
      if (internet){
        getData(),
      }
    });
  }

  // get data
  Future<Null> getData() async {
    mychat_id = await FlutterSession().get(MyConstant.SESSION_FIREBASE_CHAT_ID);
    loginuser_name = await FlutterSession().get(MyConstant.SESSION_NAME);
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) =>
    {
      APIServices()
          .getFriendList(RequestToken(user_id: userid.toString()))
          .then((dest_value) =>
      {
        responsefriendrequlist = dest_value,
        if(responsefriendrequlist.status == 200){
          success = 200,
        },
      setState(() {
      is_loading = false;
      }),
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeView()));
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: MyColors.COLOR_STATUS_BAR,
        ),
        key: _scaffold_key,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                MyColors.COLOR_PRIMARY_DARK,
                MyColors.COLOR_PRIMARY_LIGHT
              ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          child: Stack(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, size: 25),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => HomeView()));
                      },
                    ),
                    Expanded(child: Center(child: Text(
                      widget.type == '0' ? 'Inbox' : 'Friends',
                      style: TextStyle(color: Colors.white, fontSize: 16),))),
                    SizedBox(width: 50,)
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colors.white,
                margin: EdgeInsets.only(top: 50),
              ),
              Container(
                margin: EdgeInsets.only(top: 55),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    widget.type == '1' ? GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) =>
                                FriendsRequestView(
                                  callfrom: MyConstant.NAV_REQUESTCALL_FREIND,)
                        ));
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: Text(
                                    'Friend Request ', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.deepOrangeAccent
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.supervised_user_circle_outlined,
                                      color: Colors.white,),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(child: Text(
                                  'You have new Friend requests ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                )),
                                Container(
                                    margin: EdgeInsets.only(right: 25),
                                    child: Icon(Icons.navigate_next,
                                      color: Colors.white,))
                              ],
                            ),
                            Container(
                              height: 1,
                              color: Colors.white,
                              margin: EdgeInsets.only(top: 10),
                            ),
                          ],
                        ),
                      ),
                    ) : Text(''),
                    is_loading ? CenterCircleIndicator() :
                    success == 200 ?
                    ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: responsefriendrequlist.user_list.length,
                      itemBuilder: (BuildContext context, int index) =>
                          FirendAdapterView(
                            selected_friend: responsefriendrequlist
                                .user_list[index],
                            loginuser_name: loginuser_name,mychat_id: mychat_id,),
                    ) :Container(
                        margin: EdgeInsets.only(top: 100),
                        child: Center(child: Text(widget.type == '0'
                            ? 'No Recent Chat'
                            : 'No Friends'),))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

}