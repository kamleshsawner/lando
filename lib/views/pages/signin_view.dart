import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_login.dart';
import 'package:lando/model/response_model/response_login.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/home_view.dart';
import 'package:lando/views/pages/signin_option_view.dart';
import 'package:lando/views/pages/signup_view.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';
import 'package:lando/views/widget/gradient_button.dart';

import 'profile/forgot_view.dart';

class SigninView extends StatefulWidget {
  @override
  _SigninViewState createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {

  var _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var is_loading = false;

  RequestLogin requestLogin;
  ResponseLogin responseLogin;

  // google login
  final googleSignIn = GoogleSignIn();


  @override
  void initState() {
    super.initState();
    requestLogin = RequestLogin();
  }

  // submit
  void _submit() async{
    final isValid = _formkey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      setState(() {
        is_loading = true;
      });
      responseLogin = await APIServices().userLogin(requestLogin);
      if(responseLogin.status==200){
        setData();
      }else{
        showerror(responseLogin.message);
      }
    }
    _formkey.currentState.save();
  }

  void setData() async{
    var session = FlutterSession();
    await session.set(MyConstant.SESSION_ID, responseLogin.user.id);
    await session.set(MyConstant.SESSION_NAME, responseLogin.user.name);
    await session.set(MyConstant.SESSION_EMAIL, responseLogin.user.email);
    await session.set(MyConstant.SESSION_DOB, responseLogin.user.birth_date);
    await session.set(MyConstant.SESSION_PHONE, responseLogin.user.mobile);
    await session.set(MyConstant.SESSION_IMAGE, responseLogin.user.image);
    await session.set(MyConstant.SESSION_IS_LOGIN, true);
    setState(() {
      is_loading =false;
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView()));
  }

  void setSocialloginData() async{
    setState(() {
      is_loading = true;
    });
    final user = FirebaseAuth.instance.currentUser;
    var session = FlutterSession();
    await session.set(MyConstant.SESSION_ID, user.uid);
    await session.set(MyConstant.SESSION_NAME, user.displayName);
    await session.set(MyConstant.SESSION_EMAIL, user.email);
    await session.set(MyConstant.SESSION_IMAGE, user.photoURL);
    await session.set(MyConstant.SESSION_IS_LOGIN, true);
    setState(() {
      is_loading =false;
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView()));
  }

  Future googleLogin() async {
    is_loading = true;
    final user = await googleSignIn.signIn();
    if (user == null) {
      is_loading = false;
      return;
    } else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      setSocialloginData();
    }
  }


  void showerror(String message) {
    setState(() {
      is_loading =false;
      Utility.showInSnackBar(message, _scaffoldKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigninOptionView()));
      },
      child: Scaffold(
        key: _scaffoldKey,
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
                    child: Stack(
                      children: <Widget>[
                        Form(
                          key: _formkey,
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
                                        validator: (email) {
                                          requestLogin.email = email;
                                          bool emailValid = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(email);
                                          if (email.isEmpty) {
                                            return 'Enter Email Address';
                                          } else if (!emailValid) {
                                            return 'Invalid Email Address';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Enter Your Email',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        obscureText: true,
                                        validator: (password) {
                                          requestLogin.password = password;
                                          if (password.isEmpty) {
                                            return 'Please Enter Password';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotView()));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.topRight,
                                        child: Text('Forgot Password ?',style: TextStyle(fontSize: 16,color: Colors.black),),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(20),
                                      child: MyGradientButton(
                                        height: 45,
                                        child:Text('Sign in',style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white
                                        ),),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: <Color>[MyColors.COLOR_PRIMARY_LIGHT,MyColors.COLOR_PRIMARY_DARK]
                                        ),
                                        onPressed: (){
                                          Utility().checkInternetConnection().then((internet) => {
                                            if(internet){
                                              _submit(),
                                        }
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(child: Container(color: Colors.black,height: 1,margin: EdgeInsets.only(right: 15),)),
                                          Text('Or',style: TextStyle(fontSize: 16,color: Colors.black),),
                                          Expanded(child: Container(color: Colors.black,height: 1,margin: EdgeInsets.only(left: 15))),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: (){
                                            // googleLogin();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            child: Image.asset(MyAssets.ASSET_ICON_GOOGLE,width: 40,height: 40,),
                                          ),
                                        ),
                                        SizedBox(width: 50,),
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          child: Image.asset(MyAssets.ASSET_ICON_FACEBOOK,width: 40,height: 40,),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Don't have an account ?",style: TextStyle(color: Colors.grey,fontSize: 14),),
                                        SizedBox(width: 10,),
                                        GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpView()));
                                            },
                                            child: Text("Create Your Account",style: TextStyle(color: MyColors.COLOR_PRIMARY_DARK,fontSize: 14),)),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        is_loading ? CenterCircleIndicator() : Text('')
                      ],
                    ),
              ))
            ],
          ),
        ),
      ),
    );
  }


}
