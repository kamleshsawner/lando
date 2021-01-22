import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/views/pages/signin_view.dart';
import 'package:lando/views/pages/signup_view.dart';
import 'package:lando/views/widget/gradient_button.dart';

class SigninOptionView extends StatefulWidget {
  @override
  _SigninOptionViewState createState() => _SigninOptionViewState();
}

class _SigninOptionViewState extends State<SigninOptionView> {
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
            Expanded(child: Center(child: Image.asset(MyAssets.ASSET_IMAGE_LOGO),),),
            Container(
              margin: EdgeInsets.fromLTRB(30,0,30,20),
              child: MyGradientButton(
              child: Text('Sign in',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),),
              gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_LIGHT,MyColors.COLOR_PRIMARY_LIGHT,]),
              height: 45,
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SigninView()));},
            )),
            Container(
              margin: EdgeInsets.fromLTRB(30,0,30,20),
              child: MyGradientButton(
              child: Text('Sign up',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),),
              gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_LIGHT,MyColors.COLOR_PRIMARY_DARK,]),
              height: 45,
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpView()));},
            ),),
          ],
        ),
      ),
    );
  }
}
