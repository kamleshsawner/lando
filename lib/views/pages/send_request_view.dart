import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/model/friends.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/views/pages/friends_request_view.dart';
import 'package:lando/views/pages/full_image_view.dart';
import 'package:lando/views/widget/gradient_button.dart';

class SendRequestView extends StatefulWidget {
  @override
  _SendRequestViewState createState() => _SendRequestViewState();
}

class _SendRequestViewState extends State<SendRequestView> {
  var _scaffold_key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width / 4.5;

    return Scaffold(
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
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
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
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    'Profile',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ))),
                  SizedBox(
                    width: 50,
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.white,
              margin: EdgeInsets.only(top: 50),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20,80,20,40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              child: ListView(
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        MyAssets.ASSET_IMAGE_DUMMY_PROFILE,
                        height: MediaQuery.of(context).size.height/2.5,
                        // width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('At the pool party i am most likely to',style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),)),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('Dancing , with a drink in one hand and a stronger drnk in another hand.',style: TextStyle(color: Colors.black87,fontSize: 20,),)),
                  Container(
                      margin: EdgeInsets.fromLTRB(30,20,30,20),
                      child: MyGradientButton(
                        child: Text('Add as friend',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                        gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_LIGHT,MyColors.COLOR_PRIMARY_DARK,]),
                        height: 45,
                        onPressed: (){
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
