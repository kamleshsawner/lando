import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/views/widget/gradient_button.dart';

class ForgotView extends StatefulWidget {
  @override
  _ForgotViewState createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: MyColors.COLOR_PRIMARY_DARK,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyAssets.ASSET_IMAGE_SPLASH),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Center(child: Image.asset(MyAssets.ASSET_IMAGE_LOGO),),),
            Flexible(
              flex: 6,
                child: Container(
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),)
              ),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(30,40,30,20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text('Forgot Password',style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB( 20,50,20,20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Your Phone Number',
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20,50,20,20),
                              child: MyGradientButton(
                                height: 45,
                                child:Text('Get OTP',style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white
                                ),),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[MyColors.COLOR_PRIMARY_LIGHT,MyColors.COLOR_PRIMARY_DARK]
                                ),
                                onPressed: (){

                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
            ))
          ],
        ),
      ),
    );
  }
}
