import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_signup.dart';
import 'package:lando/model/response_model/response_login.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/question_view.dart';
import 'package:lando/views/pages/signin_option_view.dart';
import 'package:lando/views/pages/signin_view.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';
import 'package:lando/views/widget/gradient_button.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}



class _SignUpViewState extends State<SignUpView> {

  var _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var is_loading = false;

  RequestSignup requestSignup;
  ResponseLogin responseLogin;


  @override
  void initState() {
    super.initState();
    requestSignup = RequestSignup();
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
      responseLogin = await APIServices().userSignup(requestSignup);
      if(responseLogin.status==200){
      }else{
        showerror(responseLogin.message);
      }
    }
    _formkey.currentState.save();
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
                                        validator: (name) {
                                          requestSignup.name = name;
                                          if (name.isEmpty) {
                                            return 'Enter your name';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Name',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        validator: (email) {
                                          requestSignup.email = email;
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
                                        keyboardType: TextInputType.phone,
                                        validator: (mobile) {
                                          requestSignup.mobile = mobile;
                                          if (mobile.isEmpty) {
                                            return 'Enter your mobile number';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Enter Your Phone Number',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        obscureText: true,
                                        validator: (password) {
                                          requestSignup.password = password;
                                          if (password.isEmpty) {
                                            return 'Enter your password';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Enter your Password',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        obscureText: true,
                                        validator: (conf_password) {
                                          if (conf_password.isEmpty) {
                                            return 'Enter confirm password';
                                          }
                                          if (requestSignup.password != conf_password) {
                                            return 'confirm password not matched';
                                          }
                                          return null;
                                        },
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
                                          Utility().checkInternetConnection().then((internet) => {
                                            if(internet){
                                              _submit(),
                                            }
                                          });
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
                                              Navigator.pushReplacement(context, MaterialPageRoute(
                                                  builder: (context) => SigninView()
                                              ));
                                            },
                                            child: Text("Sign in",style: TextStyle(color: MyColors.COLOR_PRIMARY_DARK,fontSize: 14),)),
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
