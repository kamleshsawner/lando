import 'package:flutter/material.dart';
import 'package:lando/model/block_users.dart';
import 'package:lando/model/friend_request.dart';
import 'package:lando/model/friends.dart';
import 'package:lando/model/venue_users.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';

class BlocUserView extends StatefulWidget {
  @override
  _BlocUserViewState createState() => _BlocUserViewState();
}

class _BlocUserViewState extends State<BlocUserView> {

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
                  Expanded(child: Center(child: Text('Block',style: TextStyle(color: Colors.white,fontSize: 16),))),
                  SizedBox(width: 40,)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              child:  ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: BlockUsers.getriendrequestList().length,
                itemBuilder: (BuildContext context, int index) => BlockUserAdapterView(selected_friend: BlockUsers.getriendrequestList()[index],),
              )
            )
          ],
        ),
      ),
    );
  }


}
