import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_forgot.dart';
import 'package:lando/model/response_model/response_forgotpassword.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/profile/forgot_otp_view.dart';
import 'package:lando/views/pages/signin_view.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';
import 'package:lando/views/widget/gradient_button.dart';

class ForgotView extends StatefulWidget {
  @override
  _ForgotViewState createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {

  var _formkey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var is_loading = false;

  RequestForgot requestForgot;
  ResponseForgotPassword responseForgotPassword;

  @override
  void initState() {
    super.initState();
    requestForgot = RequestForgot();
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
      responseForgotPassword = await APIServices().userForgotPassword(requestForgot);
      if(responseForgotPassword.status==200){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotOtpView(responseForgotPassword: responseForgotPassword,)));
      }else{
        showerror(responseForgotPassword.message);
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigninView()));
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
                                        validator: (email) {
                                          requestForgot.email = email;
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
                                          hintText: 'Enter Your Email ',
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
                                          Utility().checkInternetConnection().then((internet) => {
                                            if(internet){
                                              _submit(),
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        if (is_loading) CenterCircleIndicator() else Text('')
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
