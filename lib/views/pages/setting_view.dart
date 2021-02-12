import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/mystrings.dart';
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
            gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_DARK,MyColors.COLOR_PRIMARY_LIGHT],
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
                  getView(MyConstant.SETTING_EDIT_PROFILE, Icons.person, context),
                  getView(MyConstant.SETTING_CHANGE_PASSWORD, Icons.lock, context),
                  getView(MyConstant.SETTING_DESTINATION, Icons.location_on_outlined, context),
                  getView(MyConstant.SETTING_BLOC_USER, Icons.block, context),
                  getView(MyConstant.SETTING_DELETE, Icons.delete_outline, context),
                  Container(
                    padding: EdgeInsets.all(20),
                    color: MyColors.COLOR_PRIMARY_DARK,
                    child: Text('More',style: TextStyle(color: Colors.black,fontSize: 16),),
                  ),
                  getView(MyConstant.SETTING_TERMS, Icons.person, context),
                  getView(MyConstant.SETTING_PRIVACY, Icons.lock, context),
                  getView(MyConstant.SETTING_ABOUT, Icons.file_present, context),
                  getView(MyConstant.SETTING_HELP, Icons.help, context),
                  getView(MyConstant.SETTING_SHARE, Icons.share, context),
                  getView(MyConstant.SETTING_RATE, Icons.star, context),
                  getView(MyConstant.SETTING_LOGOUT, Icons.logout, context)
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
        padding: EdgeInsets.only(left: 10, right: 15),
        height: 50,
        child: Row(
          children: <Widget>[
            SizedBox(width: 10,),
            Icon(icon,color: Colors.white,),
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
      ),
    );
  }

  void openNewPage(String name) {
    if(name == MyConstant.SETTING_BLOC_USER){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => BlocUserView()
      ));
    }
    if(name == MyConstant.SETTING_EDIT_PROFILE){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => EditProfileView()
      ));
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
          builder: (context) => ATPView(title: name,cotent: MyString.DUMMY_CONTENT,)
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

  }

}
