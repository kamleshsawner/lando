import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/chat/auth.dart';
import 'package:lando/chat/database.dart';
import 'package:lando/model/request_model/request_signup.dart';
import 'package:lando/model/response_model/response_login.dart';
import 'package:lando/model/user.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
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

  String _date = "Select Date of Birth";

  List gender=["Male","Female","Other"];
  String select;

  // push otification
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  var token = '';


  @override
  void initState() {
    super.initState();
    requestSignup = RequestSignup();
    getFirebaseToken();
  }

  void getFirebaseToken() {
    _firebaseMessaging.getToken().then((gen_token) {
      token = gen_token;
    });
  }

  // submit
  void _submit() async{
    final isValid = _formkey.currentState.validate();

    if(!myValidtion()){
      return;
    }else if (!isValid) {
      return;
    } else {
      setState(() {
        is_loading = true;
      });
      requestSignup.device_token = token;
      responseLogin = await APIServices().userSignup(requestSignup);
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
    await session.set(MyConstant.SESSION_FIREBASE_CHAT_ID, responseLogin.user.firebase_chatid);
    await session.set(MyConstant.SESSION_NAME, responseLogin.user.name);
    await session.set(MyConstant.SESSION_EMAIL, responseLogin.user.email);
    await session.set(MyConstant.SESSION_DOB, responseLogin.user.birth_date);
    await session.set(MyConstant.SESSION_PHONE, responseLogin.user.mobile);
    await session.set(MyConstant.SESSION_IMAGE, responseLogin.user.image);
    await session.set(MyConstant.SESSION_GENDER, responseLogin.user.gender);
    await session.set(MyConstant.SESSION_IS_LOGIN, true);

    firebasesingUp();

    // setState(() {
    //   is_loading =false;
    // });
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuestionsView()));

  }


    firebasesingUp() async {
    setState(() {
      is_loading =true;
    });
    AuthService authService = new AuthService();
    DatabaseMethods databaseMethods = new DatabaseMethods();
    await authService.signUpWithEmailAndPassword(requestSignup.email,
        requestSignup.email).then((result){
            if(result != null){
              Map<String,String> userDataMap = {
                "userName" : responseLogin.user.firebase_chatid,
                "userEmail" : requestSignup.email,
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
                                    ),
                                    Container(
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
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Text('Date Of Birth',style: TextStyle(
                                          fontSize: 16,color: Colors.black
                                      ),),
                                    ),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            child: FlatButton(
                                              onPressed: () {
                                                DatePicker.showDatePicker(context,
                                                    theme: DatePickerTheme(
                                                      containerHeight: 210.0,
                                                    ),
                                                    showTitleActions: true,
                                                    minTime: DateTime(1900, 1, 1),
                                                    // maxTime: new DateTime(2000,12,31)
                                                    maxTime: new DateTime(DateTime.now().year-18,DateTime.now().month,DateTime.now().day)
                                                    , onConfirm: (date) {
                                                      print('confirm $date');
                                                      _date = '${date.day}-${date.month}-${date.year}';
                                                      setState(() {});
                                                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 50.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Text(
                                                                "  $_date",
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 16.0,
                                                                    fontStyle: FontStyle.normal),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Icon(Icons.date_range,color: Colors.black45,)

                                                  ],
                                                ),
                                              ),
                                              color: Colors.white,
                                            ),
                                          ),
                                          // datetime()
                                        ],
                                      ),
                                    ),
                                    // GestureDetector(
                                    //   onTap: (){
                                    //     _getdobDate();
                                    //   },
                                    //   child: Container(
                                    //     margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                                    //     alignment: Alignment.topLeft,
                                    //     child: dateofbirth == null ? Text(
                                    //       'Select Date of Birth',style: TextStyle(color: Colors.grey,fontSize: 16),
                                    //     ) : Text(
                                    //       Utility.getFormatedDate(dateofbirth),style: TextStyle(color: Colors.black,fontSize: 16),
                                    //     ),
                                    //   ),
                                    // ),
                                    Container(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                      child: Text('Select Gender',style: TextStyle(
                                        fontSize: 16,color: Colors.black
                                      ),),
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          addRadioButton(0, 'Male'),
                                          addRadioButton(1, 'Female'),
                                          addRadioButton(2, 'Others'),
                                        ],
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

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value){
            setState(() {
              print(value);
              select=value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  bool myValidtion() {
    if(_date == 'Select Date of Birth'){
      Utility.showInSnackBar('Please select Date of Birth', _scaffoldKey);
      return false;
    }else if(select == null){
      Utility.showInSnackBar('Please select Gender', _scaffoldKey);
      return false;
    }else{
      requestSignup.dob = _date;
      requestSignup.gender = select;
      print(requestSignup.tojson());
      return true;
    }
  }
}
