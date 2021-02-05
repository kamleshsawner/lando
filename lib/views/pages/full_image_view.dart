import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/model/friends.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/views/pages/friends_request_view.dart';
import 'package:lando/views/widget/gradient_button.dart';

class FullImageView extends StatefulWidget {
  @override
  _FullImageViewState createState() => _FullImageViewState();
}

class _FullImageViewState extends State<FullImageView> {
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
        child: Stack(
          children: <Widget>[
            Container(
              height: 55,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.cancel, size: 25),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    'Lando',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ))),
                  Text('1/10',style: TextStyle(color: MyColors.COLOR_PRIMARY_DARK,fontSize: 18),)
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 65,bottom: 10,left: 10,right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  MyAssets.ASSET_IMAGE_SPLASH,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 65,bottom: 10,left: 10,right: 10),
              child: Column(
                children: <Widget>[
                  Expanded(child: Text('')),
                  Container(
                    alignment: Alignment.center,
                    child: Text('Sara , 23',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text('')),
                        Container(
                          margin: EdgeInsets.only(left: 15,right: 15),
                          width: 70,height: 70,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),color: Colors.white),
                          child: Icon(Icons.cancel,size: 40,color: Colors.red,),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15,right: 15),
                          width: 70,height: 70,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),color: Colors.white),
                          child: Icon(Icons.chat,size:40,color: Colors.black,),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15,right: 15),
                          width: 70,height: 70,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),color: Colors.white),
                          child: Icon(Icons.favorite,size: 40,color: Colors.red,),
                        ),
                        Expanded(child: Text('')),
                      ],
                    ),
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
