import 'package:flutter/material.dart';
import 'package:lando/model/friend_request.dart';
import 'package:lando/model/friends.dart';
import 'package:lando/model/venue_users.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';

class VenueUserView extends StatefulWidget {
  @override
  _VenueUserViewState createState() => _VenueUserViewState();
}

class _VenueUserViewState extends State<VenueUserView> {

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
                  Expanded(child: Center(child: Text('Ayia Napa',style: TextStyle(color: Colors.white,fontSize: 16),))),
                  IconButton(
                    icon: Icon(Icons.search_rounded,size: 25),
                    color: Colors.white,
                    onPressed: (){
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
            Container(
              margin: EdgeInsets.only(top: 60),
              child:  ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: VenueUsers.getriendrequestList().length,
                itemBuilder: (BuildContext context, int index) => VenueUserAdapterView(selected_friend: VenueUsers.getriendrequestList()[index],),
              )
            )
          ],
        ),
      ),
    );
  }


}