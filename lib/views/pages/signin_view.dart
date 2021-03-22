import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/chat/auth.dart';
import 'package:lando/chat/database.dart';
import 'package:lando/model/request_model/request_login.dart';
import 'package:lando/model/request_model/request_social_login.dart';
import 'package:lando/model/response_model/response_login.dart';
import 'package:lando/model/user.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/home_view.dart';
import 'package:lando/views/pages/question_view.dart';
import 'package:lando/views/pages/signin_option_view.dart';
import 'package:lando/views/pages/signup_view.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';
import 'package:lando/views/widget/gradient_button.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'profile/forgot_view.dart';

class SigninView extends StatefulWidget {
  @override
  _SigninViewState createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {

  static String EMAIL_TYPE  = 'email';
  static String GOOGLE_TYPE  = 'google';
  static String FACEBOOK_TYPE  = 'facebook';

  var _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var is_loading = false;

  RequestLogin requestLogin;
  ResponseLogin responseLogin;

  // google login
  final googleSignIn = GoogleSignIn();

  // facebook login
  final facebookLogin = FacebookLogin();

  // push otification
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  var token = '';

  @override
  void initState() {
    super.initState();
    requestLogin = RequestLogin();
    getFirebaseToken();
  }

  void getFirebaseToken() {
    _firebaseMessaging.getToken().then((gen_token) {
      token = gen_token;
    });
  }


  // submit
  void _submit() async{
    print('my token is - $token');
    final isValid = _formkey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      setState(() {
        is_loading = true;
      });
      requestLogin.device_token = token;
      responseLogin = await APIServices().userLogin(requestLogin);
      if(responseLogin.status==200){
        setData(responseLogin.status,EMAIL_TYPE);
      }else{
        showerror(responseLogin.message);
      }
    }
    _formkey.currentState.save();
  }

  // facebook login
  _loginWithFB() async{

    Map userProfile;
    // final result = await facebookLogin.logInWithReadPermissions(['email']);
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        userProfile = profile;
        var name = userProfile["name"];
        var email = userProfile["email"];
        var social_id = userProfile["id"].toString();
        RequestSocialLogin requestSocialLogin = RequestSocialLogin(name: name,email: email,social_id: social_id,social_type: 'facebook');
        print(requestSocialLogin.tojson().toString());
        socialSubmit(requestSocialLogin,FACEBOOK_TYPE);
        break;

      case FacebookLoginStatus.cancelledByUser:
        Utility.showToast('cancel by user');
        setState(() => is_loading = false );
        break;
      case FacebookLoginStatus.error:
        print('error - '+result.errorMessage);
        Utility.showToast('error'+result.errorMessage);
        setState(() => is_loading = false );
        break;
    }

  }

  // social submit
  void socialSubmit(RequestSocialLogin requestSocialLogin,String type) async{

    requestSocialLogin.device_token = token;
    responseLogin = await APIServices().userSocialLogin(requestSocialLogin);
    print('status - ${responseLogin.status}');
    if(responseLogin.status==200 || responseLogin.status==201 ){
      // 200 - new user
      // 201 - old user
      setData(responseLogin.status,type);
    }else{
      showerror(responseLogin.message);
    }
  }

  void setData(int status,String type) async{

    if(type == EMAIL_TYPE || type == GOOGLE_TYPE|| type == FACEBOOK_TYPE){
      var session = FlutterSession();
      print('user id  - ${responseLogin.user.id}');
      await session.set(MyConstant.SESSION_ID, responseLogin.user.id);
      await session.set(MyConstant.SESSION_FIREBASE_CHAT_ID, responseLogin.user.firebase_chatid);
      await session.set(MyConstant.SESSION_NAME, responseLogin.user.name);
      await session.set(MyConstant.SESSION_EMAIL, responseLogin.user.email);
      await session.set(MyConstant.SESSION_DOB, responseLogin.user.birth_date);
      await session.set(MyConstant.SESSION_PHONE, responseLogin.user.mobile);
      await session.set(MyConstant.SESSION_IMAGE, responseLogin.user.image);
      await session.set(MyConstant.SESSION_GENDER, responseLogin.user.gender);
      await session.set(MyConstant.SESSION_IS_LOGIN, true);
    }
    if(status == 200 && type == EMAIL_TYPE){
      firebaseLogin();
    }else if(status == 200 && type == GOOGLE_TYPE ){
      googleFirebaseSingUp(responseLogin.user);
    }else if(status == 200 && type == FACEBOOK_TYPE ){
      facebookFirebaseSingUp(responseLogin.user);
    }else if(status == 201 && type == GOOGLE_TYPE){
      setState(() {
        is_loading =false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView()));
    }else if(status == 201 && type == FACEBOOK_TYPE){
      firebaseLogin();
    }
  }

  googleFirebaseSingUp(User user) async {

    print('firebase sign up - '+user.email+' ,'+user.firebase_chatid);
    setState(() {
      is_loading =true;
    });
    AuthService authService = new AuthService();
    DatabaseMethods databaseMethods = new DatabaseMethods();
      Map<String,String> userDataMap = {
        "userName" : user.firebase_chatid,
        "userEmail" : user.email,
        "token" : token
      };
      print('user info - '+userDataMap.toString());
      databaseMethods.addUserInfo(userDataMap);
      setState(() {
        is_loading =false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuestionsView()));
  }


  facebookFirebaseSingUp(User user) async {

    print('firebase sign up - '+user.email+' ,'+user.firebase_chatid);
    setState(() {
      is_loading =true;
    });
    AuthService authService = new AuthService();
    DatabaseMethods databaseMethods = new DatabaseMethods();
    await authService.signUpWithEmailAndPassword(user.email,
        user.email).then((result){
      if(result != null){
        Map<String,String> userDataMap = {
          "userName" : user.firebase_chatid,
          "userEmail" : user.email,
          "token" : token
        };
        print('user info - '+userDataMap.toString());
        databaseMethods.addUserInfo(userDataMap);
        setState(() {
          is_loading =false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuestionsView()));
      }
    });
  }

  firebaseLogin() async {
    setState(() {
      is_loading =true;
    });
    AuthService authService = new AuthService();
    DatabaseMethods databaseMethods = new DatabaseMethods();
    await authService.signInWithEmailAndPassword(responseLogin.user.email,
        responseLogin.user.email).then((result){
      if(result != null){
        setState(() {
          is_loading =false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView()));
      }
    });
  }


  Future googleLogin() async {
    setState(() {
      is_loading = true;
    });
    final user = await googleSignIn.signIn();
    if (user == null) {
      setState(() {
        is_loading = false;
      });
      return;
    } else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      authResult.user.email;
      var social_id = user.id;
      var type = 'Google';
      var email = user.email;
      var name = user.displayName;
      RequestSocialLogin requestSocialLogin = RequestSocialLogin(name: name,email: email,social_id: social_id,social_type: type);
      print(requestSocialLogin.tojson().toString());
      socialSubmit(requestSocialLogin,GOOGLE_TYPE);
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
                                        GestureDetector(
                                          onTap: (){
                                            // _loginWithFB();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            child: Image.asset(MyAssets.ASSET_ICON_FACEBOOK,width: 40,height: 40,),
                                          ),
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
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpView()));
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
