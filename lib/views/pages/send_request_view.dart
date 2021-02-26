import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_check_friendship.dart';
import 'package:lando/model/request_model/request_sendrequest.dart';
import 'package:lando/model/response_model/response_destination_user.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/model/response_model/response_myprofile.dart';
import 'package:lando/model/response_model/response_send_request.dart';
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
  var is_loading = true;
  ResponseSendRequest response_ques_ans;

  @override
  void initState() {
    super.initState();
    getData();
  }


  Future<Null> getData() async{
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
      APIServices().checkOtherUserProfile(RequestCheckFriendship(userid: userid.toString(),action_userid: widget.user.id.toString())).then((response) => {
        response_ques_ans = response,
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
            is_loading ? CenterCircleIndicator() :
            Container(
              margin: EdgeInsets.fromLTRB(20,80,20,40),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
              ),
              child: ListView(
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          image: NetworkImage(Utility.getCompletePath(widget.user.image)),
                          placeholder: AssetImage(MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE),
                          height: MediaQuery.of(context).size.height/2.5,
                          fit: BoxFit.fill,
                          // width:60,
                        )
                    ),),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(widget.user.name,style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),)),
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: getLength(),
                    itemBuilder: (BuildContext context, int index) =>
                        ProfileAdapterView(response_ques_ans: response_ques_ans,index: index,),
                  ),
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
            )
          ],
        ),
      ),
    );
  }

  String getButtonStatus() {
    if(widget.status == 0) return 'Add as friend';
    if(widget.status == 1) return 'Sent Request';
    if(widget.status == 2) return 'Friends';
    if(widget.status == 3) return 'Rejected';
    if(widget.status == 4) return 'Friends';
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


  int getLength() {
    if(response_ques_ans.gallery_list == null || response_ques_ans.list_ques_ans.length >  response_ques_ans.gallery_list.length){
      return response_ques_ans.list_ques_ans.length;
    }else{
      return response_ques_ans.gallery_list.length;
    }
  }

}

class ProfileAdapterView extends StatelessWidget{

  final ResponseSendRequest response_ques_ans;
  final int index;

  const ProfileAdapterView({Key key, this.response_ques_ans,this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          MyWidget(response_ques_ans.list_ques_ans[index]),
          response_ques_ans.gallery_list != null ?
          response_ques_ans.gallery_list.length > index ? MyImage(response_ques_ans.gallery_list[index],context) : SizedBox(width: 0,height: 0,) :SizedBox(width: 0,height: 0,),
        ],
      ),
    );
  }

  Widget MyWidget(QuestionAnswer questionanswer) {

    if(questionanswer.answer == '' || questionanswer.answer == null){
      return SizedBox(width: 0,height: 0,);
    }else{
      return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(questionanswer.question
              ,style: TextStyle(color: Colors.black,fontSize: 16),),
            SizedBox(height: 10,),
            Text(questionanswer.answer
              ,style: TextStyle(color: Colors.black87,fontSize: 22,fontWeight: FontWeight.w500),)
          ],
        ),
      );
    }
  }

  Widget MyImage(UserGallery gallery_list, BuildContext context) {

    return Container(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
            image: NetworkImage(Utility.getCompletePath(gallery_list.image)),
            placeholder: AssetImage(MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE),
            // width:60,
          )
      ),);
  }


}

