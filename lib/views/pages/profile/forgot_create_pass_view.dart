import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_create_password.dart';
import 'package:lando/model/request_model/request_forgot.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/signin_view.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';
import 'package:lando/views/widget/gradient_button.dart';

class ForgotCreatePassView extends StatefulWidget {
  @override
  _ForgotCreatePassViewState createState() => _ForgotCreatePassViewState();
}

class _ForgotCreatePassViewState extends State<ForgotCreatePassView> {
  var _formkey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var is_loading = false;

  RequestCreatePassword requestCreatepassword;
  ResponseMessage responseMessage;

  @override
  void initState() {
    super.initState();
    requestCreatepassword = RequestCreatePassword();
  }

  // submit
  void _submit() async {
    final isValid = _formkey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      setState(() {
        is_loading = true;
      });
      responseMessage = await APIServices().createPassword(requestCreatepassword);
      if (responseMessage.status == 200) {
      } else {
        showerror(responseMessage.message);
      }
    }
    _formkey.currentState.save();
  }

  void showerror(String message) {
    setState(() {
      is_loading = false;
      Utility.showInSnackBar(message, _scaffoldKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SigninView()));
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
                  fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Center(
                  child: Image.asset(MyAssets.ASSET_IMAGE_LOGO),
                ),
              ),
              Flexible(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        )),
                    child: Stack(
                      children: <Widget>[
                        Form(
                          key: _formkey,
                          child: ListView(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(30, 40, 30, 20),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Create New Password',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        obscureText: true,
                                        validator: (password) {
                                          requestCreatepassword.password = password;
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
                                          requestCreatepassword.conf_password = conf_password;
                                          if (conf_password.isEmpty) {
                                            return 'Enter confirm password';
                                          }
                                          if (requestCreatepassword.password != conf_password) {
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
                                      margin:
                                          EdgeInsets.fromLTRB(20, 50, 20, 20),
                                      child: MyGradientButton(
                                        height: 45,
                                        child: Text(
                                          'Confirm',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: <Color>[
                                              MyColors.COLOR_PRIMARY_LIGHT,
                                              MyColors.COLOR_PRIMARY_DARK
                                            ]),
                                        onPressed: () {
                                          Utility()
                                              .checkInternetConnection()
                                              .then((internet) => {
                                                    if (internet)
                                                      {
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
