import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_changepass.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  var _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var is_loading = false;

  RequestChangePass requestchangepass;
  ResponseMessage responsemessage;

  @override
  void initState() {
    super.initState();
    requestchangepass = RequestChangePass();
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
      var user_id = await FlutterSession().get(MyConstant.SESSION_ID);
      requestchangepass.user_id = user_id.toString();
      responsemessage = await APIServices().changePassword(requestchangepass);
      showerror(responsemessage.message);
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: MyColors.COLOR_STATUS_BAR,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          MyColors.COLOR_PRIMARY_DARK,
          MyColors.COLOR_PRIMARY_LIGHT
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Stack(
          children: <Widget>[
            Container(
              height: 55,
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
                    'Change Password',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ))),
                  SizedBox(
                    width: 50,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 55),
              child: Form(
                key: _formkey,
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 25, right: 25, bottom: 10),
                      child: TextFormField(
                        validator: (old) {
                          requestchangepass.old_pass = old;
                          if (old.isEmpty) {
                            return "Please enter old password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          labelText: 'Old Password',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 25, right: 25, bottom: 10),
                      child: TextFormField(
                        validator: (new_pass) {
                          requestchangepass.new_pass = new_pass;
                          if (new_pass.isEmpty) {
                            return "Please enter New password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          labelText: 'New Password',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 25, right: 25, bottom: 10),
                      child: TextFormField(
                        validator: (conf_pass) {
                          requestchangepass.conf_password = conf_pass;
                          if (conf_pass.isEmpty) {
                            return "Please enter confirm password";
                          }
                          if (requestchangepass.new_pass != conf_pass) {
                            return "Confirm password not matched";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          labelText: 'confirm Password',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          margin: EdgeInsets.all(15),
                          height: 50,
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: () {
                              _submit();
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  color: MyColors.COLOR_PRIMARY_DARK,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10),
                                side: BorderSide(color: Colors.grey)),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            is_loading ? CenterCircleIndicator() : Text('')
          ],
        ),
      ),
    );
  }
}
