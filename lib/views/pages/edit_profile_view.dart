import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/model/friends.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/views/pages/friends_request_view.dart';
import 'package:lando/views/pages/full_image_view.dart';
import 'package:lando/views/widget/gradient_button.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
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
                    'Edit Profile',
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
              margin: EdgeInsets.only(top: 55),
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(65),
                          child: Image.asset(
                            MyAssets.ASSET_IMAGE_DUMMY_PROFILE,
                            width: 120.0,
                            height: 120.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FullImageView()));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              MyAssets.ASSET_IMAGE_DUMMY_PROFILE,
                              width: size,
                              height: size,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FullImageView()));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              MyAssets.ASSET_IMAGE_DUMMY_PROFILE,
                              width: size,
                              height: size,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FullImageView()));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              MyAssets.ASSET_IMAGE_DUMMY_PROFILE,
                              width: size,
                              height: size,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Icon(
                            Icons.add_circle,
                            color: Colors.redAccent,
                            size: 45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        hintText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        hintText: 'Date Of Birth',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    padding: EdgeInsets.all(15),
                    child: Text('Question',style: TextStyle(color: Colors.white),),
                  ),
                  Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('what should be your idea first date ?',style: TextStyle(color: Colors.white,fontSize: 18),),
                              SizedBox(height: 10,),
                              Text('Tried and true a casual dinner',style: TextStyle(color: Colors.black87,fontSize: 20,),)
                            ],
                          ),
                        ),
                        Icon(Icons.navigate_next,size: 50,color: Colors.black87,)
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(30,20,30,20),
                      child: MyGradientButton(
                        child: Text('Edit',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),),
                        gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_DARK,MyColors.COLOR_PRIMARY_DARK,]),
                        height: 45,
                        onPressed: (){
                          },
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(30,10,30,20),
                      child: MyGradientButton(
                        child: Text('Update',style: TextStyle(fontSize: 18,color: MyColors.COLOR_PRIMARY_DARK,fontWeight: FontWeight.w400),),
                        gradient: LinearGradient(colors: [Colors.white,Colors.white,]),
                        height: 45,
                        onPressed: (){
                          },
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
