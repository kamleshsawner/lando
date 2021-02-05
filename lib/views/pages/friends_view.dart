import 'package:flutter/material.dart';
import 'package:lando/model/friends.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/views/pages/friends_request_view.dart';

class FriendsView extends StatefulWidget {
  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {

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
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_DARK,MyColors.COLOR_PRIMARY_LIGHT],
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
                    icon: Icon(Icons.arrow_back_ios,size: 25),
                    color: Colors.white,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(child: Center(child: Text('Friends',style: TextStyle(color: Colors.white,fontSize: 16),))),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => FriendsRequestView()
                      ));
                    },
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Text(
                                  'Friend Request ',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                width: 25,height: 25,
                                decoration: BoxDecoration(
                                  color: MyColors.COLOR_PRIMARY_LIGHT,
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: Center(
                                  child: Text(
                                    '1 ',style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15,right: 15),
                                height: 50,width: 50,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                                  color: Colors.deepOrangeAccent
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.supervised_user_circle_outlined,color: Colors.white,),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(child: Text(
                                'You have new Friend requests ',style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              )),
                              Container(
                                  margin: EdgeInsets.only(right: 25),
                                  child: Icon(Icons.navigate_next,color: Colors.white,))
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
                  ),
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Friends.getriendList().length,
                  itemBuilder: (BuildContext context, int index) => FirendAdapterView(selected_friend: Friends.getriendList()[index],),
                )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
