import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_selectdestination.dart';
import 'package:lando/model/response_model/response_destination.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/dialog/dialog_exit.dart';
import 'package:lando/views/pages/edit_profile_view.dart';
import 'package:lando/views/pages/friends_view.dart';
import 'package:lando/views/pages/package_view.dart';
import 'package:lando/views/pages/setting_view.dart';
import 'package:lando/views/pages/venue_user_view.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  var _scaffold_key = GlobalKey<ScaffoldState>();
  var is_loading = true;
  var is_loading_select = false;
  ResponseDestination responseDestination;

  void exitApp() {
    showDialog(
        context: context,
        builder: (BuildContext context) => DialogExit()).then((value) {
      if (value == MyConstant.LOGOUT_YES) {
        SystemNavigator.pop();
      }
    });
  }

  void openNewpage(name) {
    if(name == MyConstant.NAV_SETTING){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  SettingView()));
    }
    if(name == MyConstant.NAV_FRIENDS){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  FriendsView()));
    }
    if(name == MyConstant.NAV_PROFILE){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  EditProfileView()));
    }
    if(name == MyConstant.NAV_PACKAGE){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  PackageView()));
    }
  }

  @override
  void initState() {
    super.initState();
    Utility().checkInternetConnection().then((internet) => {
      if (internet){
          getData(),
        }
    });
  }

  // get data
  Future<Null> getData() async {
    await APIServices().getDestination().then((dest_value) => {
      responseDestination = dest_value,
      setState(() {
        is_loading = false;
      }),
    });
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 2.7;
    final double itemWidth = size.width / 2;

    return WillPopScope(
      onWillPop: (){
        exitApp();
      },
      child: Scaffold(
        key: _scaffold_key,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: MyColors.COLOR_STATUS_BAR,
        ),
        drawer: MyDrawer(
          onTap: (ctx, name) {
            setState(() {
              Navigator.pop(context);
              openNewpage(name);
            });
          },
        ),
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
                      icon: Icon(Icons.menu,size: 30),
                      color: Colors.white,
                      onPressed: (){
                        _scaffold_key.currentState.openDrawer();
                      },
                    ),
                    Expanded(child: Image.asset(MyAssets.ASSET_IMAGE_LOGO)),
                    Icon(Icons.chat_bubble,color: Colors.white,size: 25,),
                  ],
                ),
              ),
              Container(margin : EdgeInsets.only(top: 50),height: 1,color: Colors.white,),
              is_loading ? CenterCircleIndicator() :
              responseDestination.dest_list != null && responseDestination.dest_list.length >0  ?
              Container(
                margin: EdgeInsets.only(top: 55),
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: GridView.count(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: (itemWidth / itemHeight),
                      children: List.generate(responseDestination.dest_list.length, (index) {
                        return Center(
                          child: DestinationAdapterView(
                              selected_destination:
                              responseDestination.dest_list[index],
                            height: itemHeight,
                            onPressed: (){
                                submitData(responseDestination.dest_list[index]);
                            },
                          ),
                        );
                      })),
                ),
              ) : Text(''),
              is_loading_select ? CenterCircleIndicator() : Text('')
            ],
          ),
        ),
      ),
    );
  }


  Future<Null> submitData(Destination destination) async{
    is_loading_select = true;
    setState(() {
    });
    ResponseMessage responsemessage;
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
      APIServices().selectDestination(RequestSelectDestination(user_id: userid.toString(),destination_id: destination.id.toString())).then((dest_value) => {
        responsemessage = dest_value,
        setState(() {
          is_loading_select = false;
        }),
        if(responsemessage.status == 200){
          Utility.showToast(responsemessage.message),
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => VenueUserView(id: destination.id.toString(),name: destination.title,)
          )),
        }else if(responsemessage.status == 201){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => VenueUserView(id: destination.id.toString(),name: destination.title,)
          )),
        }else{
          if(responsemessage.message == 'Group already purchased'){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => VenueUserView(id: destination.id.toString(),name: destination.title,)
            )),
          }else{
            Utility.showInSnackBar(responsemessage.message,_scaffold_key),
          }
        }
      })
    });
  }

}

class MyDrawer extends StatelessWidget {
  final Function onTap;

  MyDrawer({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_DARK,MyColors.COLOR_PRIMARY_LIGHT],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_DARK,MyColors.COLOR_PRIMARY_LIGHT],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(65),
                    ),
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              getView(MyAssets.ASSET_ICON_NAV_LOCATION, MyConstant.NAV_LOCATION, context),
              getView(MyAssets.ASSET_ICON_NAV_PROFILE, MyConstant.NAV_PROFILE, context),
              getView(MyAssets.ASSET_ICON_NAV_SETTING, MyConstant.NAV_SETTING, context),
              getView(MyAssets.ASSET_ICON_NAV_FRIENDS, MyConstant.NAV_FRIENDS, context),
              getView(MyAssets.ASSET_ICON_NAV_PRIME, MyConstant.NAV_PACKAGE, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget getView(String icon, String name, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(context, name);
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 15),
        height: 40,
        child: Row(
          children: <Widget>[
            Image.asset(
              icon,
              width: 25,
              height: 25,
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
