import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_token.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/mystrings.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/dialog/dialog_delete_account.dart';
import 'package:lando/views/dialog/dialog_logout.dart';
import 'package:lando/views/pages/a_t_p_view.dart';
import 'package:lando/views/pages/bloc_user_view.dart';
import 'package:lando/views/pages/change_pass_view.dart';
import 'package:lando/views/pages/contact_us_view.dart';
import 'package:lando/views/pages/edit_profile_view.dart';
import 'package:lando/views/pages/signin_view.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {

  var _scaffold_key = GlobalKey<ScaffoldState>();
  var is_loading = false;

Future<Null> deleteAccount() async{
    is_loading = true;
    setState(() {
    });
    ResponseMessage responsemessage;
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
      APIServices().deleteAccount(RequestToken(user_id: userid.toString())).then((response) => {
        responsemessage = response,
        setState(() {
          is_loading = false;
        }),
        Utility.showToast(responsemessage.message),
        FlutterSession().set(MyConstant.SESSION_ID, ''),
        Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SigninView()),
                ModalRoute.withName("/")),
      })
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: MyColors.COLOR_STATUS_BAR,
      ),
      key: _scaffold_key,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_LIGHT,MyColors.COLOR_PRIMARY_DARK],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,size: 25),
                    color: Colors.white,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(child: Center(child: Text('Setting',style: TextStyle(color: Colors.white,fontSize: 16),))),
                  SizedBox(width: 50,)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 55),
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    height: 1,
                    color: Colors.white,
                  ),
                  getView(MyConstant.SETTING_DESTINATION, Icons.send_outlined, context),
                  getView(MyConstant.SETTING_EDIT_PROFILE, Icons.person_outline, context),
                  getView(MyConstant.SETTING_CHANGE_PASSWORD, Icons.lock_outline, context),
                  SizedBox(height: 50,),
                  Container(
                    margin: EdgeInsets.only(top: 12,left: 12,right: 12),
                    height: 1,
                    color: Colors.white,
                  ),
                  getView(MyConstant.SETTING_BLOC_USER, Icons.remove_circle_outline, context),
                  getView(MyConstant.SETTING_TERMS, Icons.insert_drive_file_outlined, context),
                  getView(MyConstant.SETTING_HELP, Icons.help_outline, context),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    child: Text(MyString.NAVIGATION_ABOUT_SETTING,style: TextStyle(color: Colors.white,fontSize: 16),
                    textAlign: TextAlign.center,
                    ),),
                  Container(
                    margin: EdgeInsets.only(top: 12,left: 12,right: 12),
                    height: 1,
                    color: Colors.white,
                  ),
                  getView(MyConstant.SETTING_LOGOUT, Icons.logout, context),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Image.asset(MyAssets.ASSET_IMAGE_LOGO,height: 70,),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text('Version 1.0',style: TextStyle(color: Colors.white,fontSize: 16),
                      textAlign: TextAlign.center,
                    ),),
                  Container(
                    margin: EdgeInsets.only(top: 12,left: 12,right: 12),
                    height: 1,
                    color: Colors.white,
                  ),
                  getView(MyConstant.SETTING_DELETE, Icons.delete_outline, context),
                  Container(
                    margin: EdgeInsets.only(top: 50,bottom: 50),
                    alignment: Alignment.bottomCenter,
                    child: Text(MyConstant.TEST_VERIOSN_APP,style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget getView(String name, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        openNewPage(name);
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 15,top: 10,bottom: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 10,),
                Icon(icon,color: Colors.black,),
                SizedBox(width: 20,),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(Icons.navigate_next,color: Colors.white,)
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              height: 1,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void openNewPage(String name) {
    if(name == MyConstant.SETTING_DESTINATION){
      Navigator.pop(context);
    }
    if(name == MyConstant.SETTING_BLOC_USER){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => BlocUserView()
      ));
    }
    if(name == MyConstant.SETTING_EDIT_PROFILE){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) =>  EditProfileView()));
    }
    if(name == MyConstant.SETTING_CHANGE_PASSWORD){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChangePasswordView()
      ));
    }
    if(name == MyConstant.SETTING_HELP){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ContactUsView()
      ));
    }
    if(name == MyConstant.SETTING_TERMS || name == MyConstant.SETTING_ABOUT || name == MyConstant.SETTING_PRIVACY ){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ATPView(title: name,cotent: MyString.TERMS_CONDITION,)
      ));
    }
    if(name == MyConstant.SETTING_LOGOUT){
        showDialog(
            context: context,
            builder: (BuildContext context) => DialogLogout()).then((value) {
          if (value == MyConstant.LOGOUT_YES) {
            FlutterSession().set(MyConstant.SESSION_ID, '');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SigninView()),
                ModalRoute.withName("/"));
          }
        });
    }
    if(name == MyConstant.SETTING_DELETE){
        showDialog(
            context: context,
            builder: (BuildContext context) => DialogDeleteAccount()).then((value) {
          if (value == MyConstant.LOGOUT_YES) {
            deleteAccount();
          }
        });
    }
  }
}
