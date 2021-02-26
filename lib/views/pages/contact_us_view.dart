import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_contactus.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';

class ContactUsView extends StatefulWidget {
  @override
  _ContactUsViewState createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {

  var _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var is_loading = false;

  RequestContactUs requestcontact;
  ResponseMessage responsemessage;


  @override
  void initState() {
    super.initState();
    requestcontact = RequestContactUs();
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
      var token = await FlutterSession().get(MyConstant.SESSION_ID);
      responsemessage = await APIServices().contactUs(requestcontact);
      if(responsemessage.status==200){
        Utility.showToast(responsemessage.message);
        Navigator.pop(context);
      }else{
        showerror(responsemessage.message);
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
                            'Contact Us',
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
                      padding:
                          EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 10),
                      child: TextFormField(
                        validator: (name) {
                          requestcontact.name = name;
                          if (name.isEmpty) {
                            return "Please enter name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1
                              )
                          ),
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

                          labelText: 'Name',
                            labelStyle: TextStyle(
                                color:Colors.white
                            ),
                            prefixIcon: Icon(Icons.person,color: Colors.white,),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 10),
                      child: TextFormField(
                        validator: (email) {
                          requestcontact.email = email;
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1
                              )
                          ),
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

                          labelText: 'Email',
                            labelStyle: TextStyle(
                                color:Colors.white
                            ),
                            prefixIcon: Icon(Icons.email,color: Colors.white,),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 10),
                      child: TextFormField(
                        maxLines: 7,
                        validator: (message) {
                          requestcontact.message = message;
                          if (message.isEmpty) {
                            return "Please enter Message";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1
                              )
                          ),
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

                          labelText: 'Message',
                            labelStyle: TextStyle(
                                color:Colors.white
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
                              'Submit',
                              style: TextStyle(color: MyColors.COLOR_PRIMARY_DARK, fontSize: 18,fontWeight: FontWeight.bold),
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
