import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/model/package.dart';
import 'package:lando/model/venue.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/views/pages/edit_profile_view.dart';
import 'package:lando/views/pages/friends_view.dart';
import 'package:lando/views/pages/setting_view.dart';

class PackageView extends StatefulWidget {
  @override
  _PackageViewState createState() => _PackageViewState();
}

class _PackageViewState extends State<PackageView> {

  var _scaffold_key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 2.5;
    final double itemWidth = size.width / 2;

    return Scaffold(
      key: _scaffold_key,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: MyColors.COLOR_STATUS_BAR,
      ),
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
                    icon: Icon(Icons.arrow_back_ios,size: 30),
                    color: Colors.white,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(child: Center(child: Text('Package',style: TextStyle(color: Colors.white,fontSize: 20),))),
                  SizedBox(width: 40,),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 55),
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: GridView.count(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: (itemWidth / itemHeight),
                        children: List.generate(Package.getVenuelist().length, (index) {
                          return Center(
                            child: PackageAdapterView(
                                selected_venue:
                                Package.getVenuelist()[index]),
                          );
                        })),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

