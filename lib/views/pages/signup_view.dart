import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/views/widget/gradient_button.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
                        padding: EdgeInsets.fromLTRB(30,20,30,20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              alignment: Alignment.topLeft,
                              child: Text('Welcome',style: TextStyle(fontSize: 16,color: Colors.black),),
                            ),Container(
                              alignment: Alignment.topLeft,
                              child: Text('Lando',style: TextStyle(fontSize: 30,color: MyColors.COLOR_PRIMARY_DARK,fontWeight: FontWeight.bold),),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                ),
                              ),
                            ),Container(
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Your Email',
                                ),
                              ),
                            ),Container(
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Your Phone Number',
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter your Password',
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.fromLTRB(20,40,20,30),
                              child: MyGradientButton(
                                height: 45,
                                child:Text('Sign Up',style: TextStyle(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Already have an account ?",style: TextStyle(color: Colors.grey,fontSize: 14),),
                                SizedBox(width: 10,),
                                GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text("Sign in",style: TextStyle(color: MyColors.COLOR_PRIMARY_DARK,fontSize: 14),)),
                              ],
                            )
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
