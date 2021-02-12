import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/block_users.dart';
import 'package:lando/model/request_model/request_check_friendship.dart';
import 'package:lando/model/request_model/request_token.dart';
import 'package:lando/model/response_model/response_friend_req_list.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';

class BlocUserView extends StatefulWidget {
  @override
  _BlocUserViewState createState() => _BlocUserViewState();
}

class _BlocUserViewState extends State<BlocUserView> {

  var _scaffold_key = GlobalKey<ScaffoldState>();
  var is_loading = true;
  var success = 0;
  var is_loading_select = false;
  ResponseFriendReqList responsefriendrequlist;

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
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
      APIServices().getBlockUserList(RequestToken(user_id: userid.toString())).then((dest_value) => {
        responsefriendrequlist = dest_value,
        if(responsefriendrequlist.status == 200){
          success = 200,
        },
        setState(() {
          is_loading = false;
        }),
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
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_DARK,MyColors.COLOR_PRIMARY_LIGHT],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 55,
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
                  Expanded(child: Center(child: Text('Blocked User',style: TextStyle(color: Colors.white,fontSize: 16),))),
                  SizedBox(width: 40,)
                ],
              ),
            ),
            is_loading ? CenterCircleIndicator() : success == 200 ? Container(
              margin: EdgeInsets.only(top: 60),
              child:  ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: responsefriendrequlist.user_list.length,
                itemBuilder: (BuildContext context, int index) => BlockUserAdapterView(
                  selected_friend: responsefriendrequlist.user_list[index],
                  onPressedunblock: (){
                    unblockUser(index);
                  },
                ),
              )
            ) : Container(
              alignment: Alignment.center,
              child: Text('No Blocked Users'),)
          ],
        ),
      ),
    );
  }

  Future<Null> unblockUser(int index) async{
    is_loading_select = true;
    setState(() {
    });
    ResponseMessage responsemessage;
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
      APIServices().blockUnblockUser(RequestCheckFriendship(userid: userid.toString(),action_userid: responsefriendrequlist.user_list[index].id.toString())).then((response) => {
        responsemessage = response,
        responsefriendrequlist.user_list.removeAt(index),
        Utility.showInSnackBar(responsemessage.message, _scaffold_key),
        setState(() {
          is_loading_select = false;
        }),
      })
    });
  }


}
