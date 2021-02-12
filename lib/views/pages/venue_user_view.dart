import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_check_friendship.dart';
import 'package:lando/model/request_model/request_destination_users.dart';
import 'package:lando/model/response_model/response_destination_user.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/chat_view.dart';
import 'package:lando/views/pages/send_request_view.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';

class VenueUserView extends StatefulWidget {

  String id;
  String name;

  VenueUserView({this.id,this.name});

  @override
  _VenueUserViewState createState() => _VenueUserViewState();
}

class _VenueUserViewState extends State<VenueUserView> {

  var _scaffold_key = GlobalKey<ScaffoldState>();
  var is_loading = true;
  var is_loading_select = false;
  ResponseDestinationUsers responseDestinationUsers;

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
    await APIServices().getDestinationUsers(RequestDestinationUsers(group_id: widget.id)).then((destuser_res) => {
      responseDestinationUsers = destuser_res,
      setState(() {
        is_loading = false;
      }),
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
                  Expanded(child: Center(child: Text(widget.name,style: TextStyle(color: Colors.white,fontSize: 16),))),
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
            is_loading ? CenterCircleIndicator() : Container(
              margin: EdgeInsets.only(top: 60),
              child:  ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: responseDestinationUsers.user_list.length,
                itemBuilder: (BuildContext context, int index) => VenueUserAdapterView(
                  selected_friend: responseDestinationUsers.user_list[index],
                  onPressed: (){
                    submitData(responseDestinationUsers.user_list[index]);
                  },
                ),
              )
            ),
            is_loading_select ? CenterCircleIndicator() : Text('')
          ],
        ),
      ),
    );
  }


  Future<Null> submitData(DestinationUser user) async{
    is_loading_select = true;
    setState(() {
    });
    ResponseMessage responsemessage;
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
      APIServices().checkFriendshipStatus(RequestCheckFriendship(userid: userid.toString(),action_userid: user.id.toString())).then((response) => {
        responsemessage = response,
        setState(() {
          is_loading_select = false;
        }),
        if(responsemessage.status == 0 || responsemessage.status == 1 || responsemessage.status == 3 ){
          Utility.showToast(responsemessage.message),
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SendRequestView(user: user,status : responsemessage.status)
          )),
        }else if(responsemessage.status == 2 ){
          Utility.showToast(responsemessage.message),
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ChatView(user: user,)
          )),
        }
      })
    });
  }


}
