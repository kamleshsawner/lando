import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/chat/database.dart';
import 'package:lando/model/request_model/request_check_friendship.dart';
import 'package:lando/model/request_model/request_user_report.dart';
import 'package:lando/model/response_model/response_destination_user.dart';
import 'package:lando/model/response_model/response_friend_req_list.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/send_request_view.dart';
import 'package:lando/views/widget/app_widgets.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';
import 'package:http/http.dart' as http;

class ChatView extends StatefulWidget {

  ReqUser reqUser;

  ChatView({this.reqUser});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

  // chat notification start

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  var serverToken = 'AAAAsbErS5I:APA91bF8HarBNEM9phK6EgbvCx5lxgA78srBBBgnLRP0ozLrEblt2nANjDiRKRJCDvUG0t4mjHXFED9fvKbxTFvisVSWgviHZVqFdgXi7b1TvPBQxi-iPR6TMXoNbc68HR-U-jR64KQS';
  Future<Map<String, dynamic>> sendAndRetrieveMessage(String title,String message) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': message,
            'title': title
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          // 'to': await firebaseMessaging.getToken(),
          'to': widget.reqUser.device_token,
        },
      ),
    );
  }

  // chat notification end

  // auto scrolling start
  ScrollController _controller;
  // auto scrolling end


  var _scaffold_key = GlobalKey<ScaffoldState>();
  var is_loading = false;
  var login_user = '';

  var mychat_id = '';

  // chat
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  String getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }


  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        Timer(Duration(milliseconds: 500),
                () => _controller.jumpTo(_controller.position.maxScrollExtent));
        return snapshot.hasData ? ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: _controller,
            itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return MessageTile(
                message: snapshot.data.documents[index].data["message"],
                sendByMe: mychat_id ==
                    snapshot.data.documents[index].data["sendBy"],
              );
            }) : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": mychat_id,
        "message": messageEditingController.text,
        'time': DateTime
            .now()
            .millisecondsSinceEpoch,
      };
      print(chatMessageMap.toString());
      print('my chat id - ' + mychat_id);
      DatabaseMethods().addMessage(
          getChatRoomId(widget.reqUser.firebase_chatid, mychat_id),
          chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : true,
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.COLOR_STATUS_BAR,
        title: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                MyColors.COLOR_PRIMARY_DARK,
                MyColors.COLOR_PRIMARY_LIGHT
              ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 55,
                padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, size: 25),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            image: NetworkImage(Utility.getCompletePath(widget
                                .reqUser.image)),
                            placeholder: AssetImage(
                                MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE),
                            height: 45,
                            width: 45,
                            fit: BoxFit.fill,
                          )
                      ),),
                    Expanded(child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                SendRequestView(user: DestinationUser(
                                    firebase_chatid: widget.reqUser
                                        .firebase_chatid,
                                    image: widget.reqUser.image,
                                    name: widget.reqUser.name,
                                    id: widget.reqUser.id
                                ), status: 4)
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(widget.reqUser.name, style: TextStyle(
                                color: Colors.white, fontSize: 18),),
                          ],
                        ),
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        _menuOption();
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Image.asset(
                          MyAssets.ASSET_ICON_CONTEXT_MENU, width: 50,
                          height: 60,),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      key: _scaffold_key,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-55,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                MyColors.COLOR_PRIMARY_DARK,
                MyColors.COLOR_PRIMARY_LIGHT
              ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 90),
                child: chatMessages(),
              ),
              getBottomView(),
              is_loading ? CenterCircleIndicator() : Text('')
            ],
          ),
        ),
      ),
    );
  }

  void _menuOption() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return Container(
            height: 340,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15,),
                      Container(
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: Text('Select Option', style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),),)),
/*
                      Container(
                          padding: EdgeInsets.all(12),
                          child: Center(child: Text('Clear All Chat',style: TextStyle(color: Colors.black,fontSize: 16),),)),
*/
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          reportUser();
                        },
                        child: Container(
                            padding: EdgeInsets.all(12),
                            child: Center(child: Text('Report User',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16),),)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          blockUser();
                        },
                        child: Container(
                            padding: EdgeInsets.all(12),
                            child: Center(child: Text('Block User',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 16),),)),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
                Container(height: 15, color: Colors.transparent,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                        padding: EdgeInsets.all(15),
                        child: Center(
                          child: Text('Cancel', style: TextStyle(color: Colors
                              .red, fontSize: 16),),)),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  Future<Null> blockUser() async {
    is_loading = true;
    setState(() {});
    ResponseMessage responsemessage;
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) =>
    {
      APIServices().blockUnblockUser(RequestCheckFriendship(
          userid: userid.toString(),
          action_userid: widget.reqUser.id.toString())).then((response) => {
      responsemessage = response,
          setState(() {
            is_loading = false;
          }),
          Utility.showInSnackBar(responsemessage.message, _scaffold_key),
          })
    });
  }

  Future<Null> reportUser() async {
    is_loading = true;
    setState(() {});
    ResponseMessage responsemessage;
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) =>
    {
      APIServices().reportUser(RequestReportUser(userid: userid.toString(),
          action_reportto: widget.reqUser.id.toString())).then((response) =>
      {
        responsemessage = response,
        setState(() {
          is_loading = false;
        }),
        Utility.showInSnackBar(responsemessage.message, _scaffold_key),
      })
    });
  }

  void getData() async {
    mychat_id = await FlutterSession().get(MyConstant.SESSION_FIREBASE_CHAT_ID);
    login_user = await FlutterSession().get(MyConstant.SESSION_NAME);
    await FlutterSession().get(MyConstant.SESSION_FIREBASE_CHAT_ID).then((
        value) {
      DatabaseMethods().getChats(
          getChatRoomId(widget.reqUser.firebase_chatid, mychat_id)).then((val) {
        setState(() {
          chats = val;
        });
        Timer(Duration(milliseconds: 500),
                () => _controller.jumpTo(_controller.position.maxScrollExtent));
      });
    });
  }

  Widget getBottomView() {
    if (widget.reqUser.is_blocked == 1 &&
        widget.reqUser.is_friend_blocked == 1) {
      return Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height-140),
        height: 60,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          color: Color(0x54FFFFFF),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                    controller: messageEditingController,
                    style: simpleTextStyle(),
                    decoration: InputDecoration(
                        hintText: "Write a message ...",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        border: InputBorder.none
                    ),
                  )),
              SizedBox(width: 16,),
              GestureDetector(
                onTap: () {
                  print('login user - $login_user');
                  sendAndRetrieveMessage(login_user,messageEditingController.text.toString(),);
                  addMessage();
                  Timer(Duration(milliseconds: 500),
                          () => _controller.jumpTo(_controller.position.maxScrollExtent));
                },
                child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.send, size: 25, color: Colors.red,)),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(alignment: Alignment.bottomCenter,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(widget.reqUser.is_blocked == 0
              ? 'Unblock to send message'
              : 'You are blocked'),
        ),
      );
    }
  }
}


class MessageTile extends StatelessWidget {

  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe ? [
                const Color(0xFFf55505),
                const Color(0xFFf55505)
              ]
                  : [
                const Color(0xFFcfcdcc),
                const Color(0xFFcfcdcc)
              ],
            )
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: sendByMe ? Colors.white : Colors.black,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
