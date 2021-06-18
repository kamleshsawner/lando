import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/chat/database.dart';
import 'package:lando/model/response_model/response_destination_user.dart';
import 'package:lando/util/myassets.dart';
import 'package:flutter/material.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/chat_view.dart';

class ResponseFriendReqList{

  int status;
  String message;
  List<ReqUser> user_list;

  ResponseFriendReqList({this.status,this.message,this.user_list});
}

class ReqUser{

  int id;
  String name;
  String image;
  int status;
  String firebase_chatid;
  int is_blocked;
  int is_friend_blocked;
  String device_token;
  String count;

  ReqUser({this.id,this.name,this.image,this.status,this.firebase_chatid,this.is_blocked,this.is_friend_blocked,this.device_token,this.count});

  factory ReqUser.fromjson(Map<String,dynamic> json){
    return ReqUser(
      id: json['id'],
      name: json['name'],
      image : json['profile'],
      status : json['is_accept'],
      firebase_chatid : json['firebase_chatid'],
      is_blocked: 1,
      is_friend_blocked: 1,
      device_token: '',
        count: ''
    );
  }

  factory ReqUser.fromjsonforfriends(Map<String,dynamic> json){

    Stream<QuerySnapshot> chats;

    return ReqUser(
      id: json['id'],
      name: json['name'],
      image : json['profile'],
      status : 0,
      firebase_chatid : json['firebase_chatid'],
      is_blocked: json['is_blocked'],
      is_friend_blocked: json['is_friend_blocked'],
        device_token: json['device_token'],
        count: ''
    );
  }

  factory ReqUser.fromjsonforfriendsforblockuser(Map<String,dynamic> json){
    return ReqUser(
      id: json['id'],
      name: json['name'],
      image : json['profile'],
      status : 0,
      firebase_chatid : json['firebase_chatid'],
      is_blocked: 1,
      is_friend_blocked: 1,
      device_token: '',
        count: ''
    );
  }

}


class FirendRequestAdapterView extends StatelessWidget{

  final ReqUser selected_friend;
  final Function onPressedaccept;
  final Function onPressedreject;

  const FirendRequestAdapterView({Key key, this.selected_friend,this.onPressedaccept,this.onPressedreject}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              selected_friend.image == '' ? ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.asset(
                  MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE,
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.fill,
                ),
              ) :
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(Utility.getCompletePath(selected_friend.image),),
                        fit: BoxFit.fill)),
              ),
              SizedBox(width: 10,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '${selected_friend.name}',style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 10,width: 10,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.green),
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                ],
              )),
              GestureDetector(
                onTap: onPressedaccept,
                child: Container(
                    padding: EdgeInsets.fromLTRB(10,8,10,8),
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(7)
                    ),
                    child: Text('Accept',style: TextStyle(color: Colors.white,fontSize: 14),)),
              ),
              SizedBox(width: 15,),
              GestureDetector(
                onTap: onPressedreject,
                child: Container(
                    margin: EdgeInsets.only(right: 25),
                    child: Icon(Icons.cancel_outlined,color: Colors.white,)),
              )
            ],
          ),
          SizedBox(height: 5,),
          Container(color: Colors.white,height: 1,)
        ],
      ),
    );
  }

}

class FirendAdapterView extends StatelessWidget{

  final ReqUser selected_friend;
  final String loginuser_name;
  final String mychat_id;
  const FirendAdapterView({Key key, this.selected_friend,this.loginuser_name,this.mychat_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print('login chat id - $mychat_id');

    return GestureDetector(
      onTap: (){
        DatabaseMethods().updateMyMessageCounte(mychat_id,selected_friend.firebase_chatid,'0');
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChatView(reqUser: selected_friend,)
        ));
      },
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: FadeInImage(
                        image: NetworkImage(Utility.getCompletePath(selected_friend.image)),
                        placeholder: AssetImage(MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE),
                        height: 60,
                        fit: BoxFit.fill,
                        width:60,
                      )
                  ),),
                SizedBox(width: 10,),
                Expanded(child: Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.transparent,
                  height: 50,
                  child: Text(
                    '${selected_friend.name}',style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  ),
                )),
                StreamBuilder(
                    stream: Firestore.instance
                        .collection('users')
                        .document(mychat_id)
                        .collection('firends')
                        .document(selected_friend.firebase_chatid).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                            margin: EdgeInsets.only(right: 25),
                            child: Icon(Icons.chat_bubble_outline,color: Colors.white,));
                      }
                      var userDocument = snapshot.data;
                      return Container(
                          margin: EdgeInsets.only(right: 25),
                          child: Icon(Icons.chat_bubble_outline,
                            color: userDocument['message_count'] == '0' ? Colors.white :Colors.green,));
                    }
                )
              ],
            ),
            SizedBox(height: 5,),
            Container(color: Colors.white,height: 1,)
          ],
        ),
      ),
    );
  }

  String getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

}
