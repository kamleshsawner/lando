import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_accept_reject.dart';
import 'package:lando/model/request_model/request_token.dart';
import 'package:lando/model/response_model/response_friend_req_list.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';

class FriendsRequestView extends StatefulWidget {
  @override
  _FriendsRequestViewState createState() => _FriendsRequestViewState();
}

class _FriendsRequestViewState extends State<FriendsRequestView> {

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
      APIServices().getFriendRequestList(RequestToken(user_id: userid.toString())).then((dest_value) => {
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
                  Expanded(child: Center(child: Text('Friend Request',style: TextStyle(color: Colors.white,fontSize: 16),))),
                  IconButton(
                    icon: Icon(Icons.search_rounded,size: 25),
                    color: Colors.white,
                    onPressed: (){
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.white,
              margin: EdgeInsets.only(top: 55),
            ),
            is_loading ? CenterCircleIndicator() :
            success == 200 ?
            Container(
              margin: EdgeInsets.only(top: 60),
              child:  ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: responsefriendrequlist.user_list.length,
                itemBuilder: (BuildContext context, int index) => FirendRequestAdapterView(
                  selected_friend: responsefriendrequlist.user_list[index],
                  onPressedaccept: (){
                    submitData(responsefriendrequlist.user_list[index],'2',index);
                  },
                  onPressedreject: (){
                    submitData(responsefriendrequlist.user_list[index],'3',index);
                  },
                ),
              )
            ) : Center(child: Text('No Friend Request'),),
            is_loading_select ? CenterCircleIndicator() : Text('')
          ],
        ),
      ),
    );
  }

  Future<Null> submitData(ReqUser requeser,String status,int index) async{
    is_loading_select = true;
    setState(() {
    });
    ResponseMessage responsemessage;
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
      APIServices().requestAcceptReject(RequestAcceptReject(id: requeser.id.toString(),status: status)).then((dest_value) => {
        responsemessage = dest_value,
        Utility.showToast(responsemessage.message),
        if(responsemessage.status == 200){
          responsefriendrequlist.user_list.removeAt(index)
        },
        setState(() {
          is_loading_select = false;
        }),
      })
    });
  }


}
