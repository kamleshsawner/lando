import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
import 'package:lando/views/dialog/dialog_package.dart';
import 'package:lando/views/dialog/dialog_package_selection.dart';
import 'package:lando/views/pages/check_allprofile_view.dart';
import 'package:lando/views/pages/edit_profile_view.dart';
import 'package:lando/views/pages/friends_view.dart';
import 'package:lando/views/pages/package_view.dart';
import 'package:lando/views/pages/setting_view.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';

import 'friends_request_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _scaffold_key = GlobalKey<ScaffoldState>();
  var is_loading = true;
  var is_showpopup = false;
  var is_loading_select = false;
  ResponseDestination responseDestination;

  var dest_list = List<Destination>();
  var image_url = '';
  var name = '';
  var email = '';

  void exitApp() {
    showDialog(
        context: context,
        builder: (BuildContext context) => DialogExit()).then((value) {
      if (value == MyConstant.LOGOUT_YES) {
        SystemNavigator.pop();
      }
    });
  }

  void DialogSelectDestination() {
    showDialog(
        context: context,
        builder: (BuildContext context) => DialogPackageSelect());
  }

  void selectDestinationforProfile() {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            DialogPackageSelection(dest_list: dest_list));
  }

  void openNewpage(name) {
    if (name == MyConstant.NAV_SETTING) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingView()));
    }
    if (name == MyConstant.NAV_FRIENDS) {
      openFriends('1');
    }
    if (name == MyConstant.NAV_PROFILE) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EditProfileView()));
    }
    if (name == MyConstant.NAV_PACKAGE) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PackageView()));
    }
  }

  @override
  void initState() {
    super.initState();
    Utility().checkInternetConnection().then((internet) => {
          if (internet)
            {
              getData(),
            }
        });
  }

  // get data
  Future<Null> getData() async {
    image_url = await FlutterSession().get(MyConstant.SESSION_IMAGE);
    name = await FlutterSession().get(MyConstant.SESSION_NAME);
    email = await FlutterSession().get(MyConstant.SESSION_EMAIL);
    int userid = await FlutterSession().get(MyConstant.SESSION_ID);
    await APIServices().getDestination(userid).then((dest_value) => {
          responseDestination = dest_value,
          is_showpopup = !showPopup(),
          if (is_showpopup)
            {
              DialogSelectDestination(),
            },
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
      onWillPop: () {
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
          image_path: image_url,
          username: name,
          user_email: email,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            MyColors.COLOR_PRIMARY_DARK,
            MyColors.COLOR_PRIMARY_LIGHT
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Stack(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.menu, size: 30),
                      color: Colors.white,
                      onPressed: () {
                        _scaffold_key.currentState.openDrawer();
                      },
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(child: Image.asset(MyAssets.ASSET_IMAGE_LOGO)),
                    IconButton(
                      icon: Icon(Icons.chat_bubble),
                      color: Colors.white,
                      iconSize: 25,
                      onPressed: () {
                        openFriends('0');
                      },
                    ),
                    _simplePopup()
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                height: 1,
                color: Colors.white,
              ),
              is_loading
                  ? CenterCircleIndicator()
                  : responseDestination.dest_list != null &&
                          responseDestination.dest_list.length > 0
                      ? Container(
                          margin: EdgeInsets.only(top: 55),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: GridView.count(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                childAspectRatio: (itemWidth / itemHeight),
                                children: List.generate(
                                    responseDestination.dest_list.length,
                                    (index) {
                                  return Center(
                                    child: DestinationAdapterView(
                                      selected_destination:
                                          responseDestination.dest_list[index],
                                      height: itemHeight,
                                      onPressed: () {
                                        submitData(responseDestination
                                            .dest_list[index]);
                                      },
                                    ),
                                  );
                                })),
                          ),
                        )
                      : Text(''),
              is_loading_select ? CenterCircleIndicator() : Text(''),
/*
              is_showpopup ? showDialog(
                  context: context,
                  builder: (BuildContext context) => DialogPackageSelect()) : Text('')
*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _simplePopup() => PopupMenuButton<int>(
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Image.asset(MyAssets.ASSET_ICON_CONTEXT_MENU),
        ),
        itemBuilder: (context) => [
/*
      PopupMenuItem(
        value: 1,
        child: Text("Check Profile"),
      ),
      PopupMenuItem(
        value: 2,
        child: Text("Settings"),
      ),
*/
          PopupMenuItem(
            value: 3,
            child: Text("Friends List"),
          ),
          PopupMenuItem(
            value: 4,
            child: Text("Friends Requests"),
          ),
        ],
        onSelected: (value) {
          if (value == 1) {
            if (dest_list.length == 0) {
              DialogSelectDestination();
            } else if (dest_list.length == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckAllProfileView(
                            id: dest_list[0].id.toString(),
                            name: dest_list[0].title,
                          )));
            } else {
              selectDestinationforProfile();
            }
          }
          if (value == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingView()));
          }
          if (value == 3) {
            openFriends('1');
          }
          if (value == 4) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => FriendsRequestView(
                          callfrom: MyConstant.NAV_REQUESTCALL_HOME,
                        )));
          }
        },
      );

  Future<Null> submitData(Destination destination) async {
    is_loading_select = true;
    setState(() {});
    ResponseMessage responsemessage;
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
          APIServices()
              .selectDestination(RequestSelectDestination(
                  user_id: userid.toString(),
                  destination_id: destination.id.toString()))
              .then((dest_value) => {
                    responsemessage = dest_value,
                    setState(() {
                      is_loading_select = false;
                    }),
                    if (responsemessage.status == 200 ||
                        responsemessage.status == 201)
                      {
                        if (responsemessage.status == 200)
                          {
                            Utility.showToast(responsemessage.message),
                          },
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckAllProfileView(
                                      id: destination.id.toString(),
                                      name: destination.title,
                                    ))),
                      }
                    else
                      {
                        Utility.showInSnackBar(
                            responsemessage.message, _scaffold_key),
                      }
                  })
        });
  }

  void openFriends(String type) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => FriendsView(
                  type: type,
                )));
  }

  bool showPopup() {
    dest_list = List<Destination>();
    var list = responseDestination.dest_list;
    for (int i = 0; i < list.length; i++) {
      if (list[i].status == 1) {
        dest_list.add(list[i]);
      }
    }
    if (dest_list.length > 0) {
      return true;
    } else {
      return false;
    }
  }
}

class MyDrawer extends StatelessWidget {
  final Function onTap;
  String image_path;
  String username;
  String user_email;

  MyDrawer({this.onTap, this.image_path, this.username, this.user_email});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        MyColors.COLOR_PRIMARY_DARK,
        MyColors.COLOR_PRIMARY_LIGHT
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            MyColors.COLOR_PRIMARY_DARK,
            MyColors.COLOR_PRIMARY_LIGHT
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    image_path == ''
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE,
                              width: 80.0,
                              height: 80.0,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      Utility.getCompletePath(image_path),
                                    ),
                                    fit: BoxFit.fill)),
                          ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  username,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(user_email, style: TextStyle(color: Colors.white)),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 1,
                color: Colors.white,
              ),
              getView(MyAssets.ASSET_ICON_NAV_LOCATION, MyConstant.NAV_LOCATION,
                  context),
              Container(
                height: 1,
                color: Colors.white,
              ),
              getView(MyAssets.ASSET_ICON_NAV_PROFILE, MyConstant.NAV_PROFILE,
                  context),
              Container(
                height: 1,
                color: Colors.white,
              ),
              getView(MyAssets.ASSET_ICON_NAV_SETTING, MyConstant.NAV_SETTING,
                  context),
              Container(
                height: 1,
                color: Colors.white,
              ),
              getView(MyAssets.ASSET_ICON_NAV_FRIENDS, MyConstant.NAV_FRIENDS,
                  context),
              Container(
                height: 1,
                color: Colors.white,
              ),
              getView(MyAssets.ASSET_ICON_NAV_PRIME, MyConstant.NAV_PACKAGE,
                  context),
              Container(
                height: 1,
                color: Colors.white,
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                alignment: Alignment.bottomCenter,
                child: Text(
                  MyConstant.TEST_VERIOSN_APP,
                  style: TextStyle(color: Colors.white),
                ),
              )
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
        height: 45,
        child: Row(
          children: <Widget>[
            Image.asset(
              icon,
              width: 25,
              height: 25,
            ),
            SizedBox(
              width: 10,
            ),
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
