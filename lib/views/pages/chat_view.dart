import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_check_friendship.dart';
import 'package:lando/model/request_model/request_user_report.dart';
import 'package:lando/model/response_model/response_destination_user.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/send_request_view.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';

class ChatView extends StatefulWidget {

  DestinationUser user;

  ChatView({this.user});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

  var _scaffold_key = GlobalKey<ScaffoldState>();
  var is_loading = false;

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
              padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,size: 25),
                    color: Colors.white,
                    onPressed: (){
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
                          image: NetworkImage(Utility.getCompletePath(widget.user.image)),
                          placeholder: AssetImage(MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE),
                          height: 45,
                          width:45,
                          fit: BoxFit.fill,
                        )
                    ),),
                  Expanded(child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SendRequestView()
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.user.name,style: TextStyle(color: Colors.white,fontSize: 18),),
                        ],
                      ),
                    ),
                  )),
                  GestureDetector(
                    onTap: (){_menuOption();},
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Image.asset(MyAssets.ASSET_ICON_CONTEXT_MENU,width: 50,height: 60,),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.white,
              margin: EdgeInsets.only(top: 55),
            ),
            is_loading ? CenterCircleIndicator() : Text('')
          ],
        ),
      ),
    );
  }

  void _menuOption(){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder){
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
                          child: Center(child: Text('Select Option',style: TextStyle(color: Colors.black,fontSize: 16),),)),
                      Container(
                          padding: EdgeInsets.all(12),
                          child: Center(child: Text('Clear All Chat',style: TextStyle(color: Colors.black,fontSize: 16),),)),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          reportUser();
                        },
                        child: Container(
                            padding: EdgeInsets.all(12),
                            child: Center(child: Text('Report User',style: TextStyle(color: Colors.black,fontSize: 16),),)),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          blockUser();
                        },
                        child: Container(
                            padding: EdgeInsets.all(12),
                            child: Center(child: Text('Block User',style: TextStyle(color: Colors.red,fontSize: 16),),)),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
                Container(height: 15,color: Colors.transparent,),
                GestureDetector(
                  onTap: (){
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
                        child: Center(child: Text('Cancel',style: TextStyle(color: Colors.red,fontSize: 16),),)),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  Future<Null> blockUser() async{
    is_loading = true;
    setState(() {
    });
    ResponseMessage responsemessage;
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
      APIServices().blockUnblockUser(RequestCheckFriendship(userid: userid.toString(),action_userid: widget.user.id.toString())).then((response) => {
        responsemessage = response,
        setState(() {
          is_loading = false;
        }),
        Utility.showInSnackBar(responsemessage.message, _scaffold_key),
      })
    });
  }

  Future<Null> reportUser() async{
    is_loading = true;
    setState(() {
    });
    ResponseMessage responsemessage;
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
      APIServices().reportUser(RequestReportUser(userid: userid.toString(),action_reportto : widget.user.id.toString())).then((response) => {
        responsemessage = response,
        setState(() {
          is_loading = false;
        }),
        Utility.showInSnackBar(responsemessage.message, _scaffold_key),
      })
    });
  }


}
