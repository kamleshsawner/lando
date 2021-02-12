import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_sendrequest.dart';
import 'package:lando/model/response_model/response_destination_user.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';
import 'package:lando/views/widget/gradient_button.dart';

class SendRequestView extends StatefulWidget {

  DestinationUser user;
  int status;

  SendRequestView({this.user,this.status});

  @override
  _SendRequestViewState createState() => _SendRequestViewState();
}

class _SendRequestViewState extends State<SendRequestView> {
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
                    icon: Icon(Icons.arrow_back_ios, size: 25),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    'Profile',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ))),
                  SizedBox(
                    width: 50,
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.white,
              margin: EdgeInsets.only(top: 50),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20,80,20,40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              child: ListView(
                children: <Widget>[

                  widget.user.image == '' ? Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE,
                        height: MediaQuery.of(context).size.height/2.5,
                        // width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ) :
                  Container(
                    height: MediaQuery.of(context).size.height/2.5,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(widget.user.image,),
                            fit: BoxFit.fill)),
                  ),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(widget.user.name,style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),)),
                  Container(
                      margin: EdgeInsets.fromLTRB(30,20,30,20),
                      child: MyGradientButton(
                        child: Text(getButtonStatus(),style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                        gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_LIGHT,MyColors.COLOR_PRIMARY_DARK,]),
                        height: 45,
                        onPressed: (){
                          submitData();
                        },
                      )),
                ],
              ),
            ),
            is_loading ? CenterCircleIndicator() : Text('')
          ],
        ),
      ),
    );
  }

  String getButtonStatus() {
    if(widget.status == 0) return 'Add as friend';
    if(widget.status == 1) return 'Sent Request';
    if(widget.status == 3) return 'Rejected';
  }

  Future<Null> submitData() async{
    if(widget.status == 0){
      is_loading = true;
      setState(() {
      });
      ResponseMessage responsemessage;
      await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
        APIServices().sendFriendRequest(RequestSendRequest(user_id: userid.toString(),sendto: widget.user.id.toString())).then((response) => {
          responsemessage = response,
          if(responsemessage.status == 200){
            widget.status = 1,
            Utility.showToast(responsemessage.message),
            setState(() {
              is_loading = false;
            }),
          }
        })
      });

    }
  }
}
