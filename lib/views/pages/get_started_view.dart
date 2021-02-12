import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/views/pages/signin_option_view.dart';
import 'package:lando/views/pages/signin_view.dart';
import 'package:lando/views/widget/gradient_button.dart';

class GetStartedView extends StatefulWidget {
  @override
  _GetStartedViewState createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {

  @override
  void initState(){
    super.initState();
  }

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
            SizedBox(height:100,),
            Expanded(child: Center(child: Image.asset(MyAssets.ASSET_IMAGE_LOGO),),),
            Expanded(child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(child: Text('')),
                  Container(
                    alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(20,0,20,10),
                      child: Text('Escape the\nOrdinary Life',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(20,0,20,0),
                      child: Text('Discover and share the best experiences around the world from ther travelers, save item to your Buckets list, share those experience once you complete them.',style: TextStyle(color: Colors.white,fontSize: 16),textAlign: TextAlign.justify,)),
                  Container(
                    margin: EdgeInsets.fromLTRB(15,30,15,15),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: MyGradientButton(
                          child: Text('Get Started',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),),
                          gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_LIGHT,MyColors.COLOR_PRIMARY_DARK,]),
                          height: 45,
                          onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigninOptionView()));},
                        )
                        ),
                        SizedBox(width: 15,),
                        MyGradientButton(child: Text('Login',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),),
                          gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_LIGHT,MyColors.COLOR_PRIMARY_DARK,]),
                          height: 45,
                          width: 100,
                          onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigninView()));},
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
