import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_alluserprofile.dart';
import 'package:lando/model/request_model/request_check_friendship.dart';
import 'package:lando/model/request_model/request_sendrequest.dart';
import 'package:lando/model/response_model/response_all_profile.dart';
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

class CheckAllProfileView extends StatefulWidget {

  String id;
  String name;

  // heart - purple
  // thumbsup - green
  /// cross - red

  CheckAllProfileView({this.id, this.name});

  @override
  _CheckAllProfileViewState createState() => _CheckAllProfileViewState();
}

class _CheckAllProfileViewState extends State<CheckAllProfileView> {

  var _scaffold_key = GlobalKey<ScaffoldState>();
  var is_loading = true;
  var is_success = false;
  ResponseAllProfile response_all_profile;
  String login_gender;

  int user_index = 0;

  @override
  void initState() {
    super.initState();
    print('id - ${widget.id}');
    print('name - ${widget.name}');
    getData();
  }

  Future<Null> getData() async {
    login_gender = await FlutterSession().get(MyConstant.SESSION_GENDER);
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) =>
    {
      APIServices().getAllUserProfile(RequestAallUserProfile(
          userid: userid.toString(), group_id: widget.id)).then((response) =>
      {
        response_all_profile = response,
        if(response_all_profile.list_profiles == null ){
          is_success = false,
        }else if(response_all_profile.list_profiles == null || response_all_profile.list_profiles.length > 0){
          is_success = true,
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
                            widget.name,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ))),
                  SizedBox(
                    width: 50,
                  )
                ],
              ),
            ),
            is_loading ? CenterCircleIndicator() :
            checkValidIndex() ? Container(
              margin: EdgeInsets.fromLTRB(20, 80, 20, 40),
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
                          image: NetworkImage(Utility.getCompletePath(
                              response_all_profile.list_profiles[user_index]
                                  .image)),
                          placeholder: AssetImage(
                              MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 2.5,
                          fit: BoxFit.fill,
                          // width:60,
                        )
                    ),),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        response_all_profile.list_profiles[user_index].name,
                        style: TextStyle(color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),)),
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: getLength(),
                    itemBuilder: (BuildContext context, int index) =>
                        ProfileAdapterView(
                          response_ques_ans: response_all_profile
                              .list_profiles[user_index], index: index,),
                  ),
                ],
              ),
            ) : Center(child: Text('No Profiles'),),
            checkValidIndex() ? Container(
              margin: EdgeInsets.fromLTRB(30, MediaQuery
                  .of(context)
                  .size
                  .height - 140, 40, 60),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: IconButton(icon: Icon(
                      Icons.cancel_rounded, color: Colors.red, size: 50,),
                      onPressed: () {
                        cancelFriend();
                      },
                    ),
                  ), Expanded(child: Text('')),
                  Container(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(issameGender() ? Icons.thumb_up :Icons.favorite, color: issameGender() ?Colors.green : Colors.purple, size: 50),
                      onPressed: () {
                        addFriend();
                      },
                    ),
                  )
                ],
              ),
            ) : Text('')
          ],
        ),
      ),
    );
  }

  bool checkValidIndex(){
    if(response_all_profile == null){
      return false;
    }
    if(response_all_profile.list_profiles == null || response_all_profile.list_profiles.length == 0){
      return false;
    }else if(user_index < response_all_profile.list_profiles.length){
      return true;
    }else{
      return false;
    }
  }

  int getLength() {
    if (response_all_profile.list_profiles[user_index].gallery_list == null ||
        response_all_profile.list_profiles[user_index].list_ques_ans.length >
            response_all_profile.list_profiles[user_index].gallery_list
                .length) {
      return response_all_profile.list_profiles[user_index].list_ques_ans
          .length;
    } else {
      return response_all_profile.list_profiles[user_index].gallery_list.length;
    }
  }

  Future<Null> addFriend() async {
    is_loading = true;
    setState(() {});
    ResponseMessage responsemessage;
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
    APIServices().sendFriendRequest(RequestSendRequest(user_id: userid.toString(), sendto: response_all_profile.list_profiles[user_index].user_id.toString())).then((response) => {
    responsemessage = response,
      if(responsemessage.status != 200){
        Utility.showToast(responsemessage.message),
      },
      user_index = ++user_index,
      setState(() {
          is_loading = false;
        }),
        })
  });

  }

  Future<Null> cancelFriend() async {
    is_loading = true;
    setState(() {});
    ResponseMessage responsemessage;
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) =>
    {
      APIServices().cancelFriendProfile(RequestCheckFriendship(
          userid: userid.toString(),
          action_userid: response_all_profile.list_profiles[user_index].user_id
              .toString())).then((response) =>
      {
        responsemessage = response,
        if(responsemessage.status == 200){
          user_index = ++user_index,
        } else
          {
            user_index = ++user_index,
            Utility.showToast(responsemessage.message),
          },
        setState(() {
          is_loading = false;
        }),
      })
    });
  }

  bool issameGender(){
    String profile_gender = response_all_profile.list_profiles[user_index].gender;
    if(login_gender == null ||login_gender == '' || profile_gender == null || profile_gender == ''){
      return true;
    }else if(login_gender == profile_gender){
      return true;
    }else{
      return false;
    }
  }

}


class ProfileAdapterView extends StatelessWidget {

  final UserProfile response_ques_ans;
  final int index;

  const ProfileAdapterView({Key key, this.response_ques_ans, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          MyWidget(response_ques_ans.list_ques_ans[index]),
          response_ques_ans.gallery_list != null ?
          response_ques_ans.gallery_list.length > index ? MyImage(
              response_ques_ans.gallery_list[index], context) : SizedBox(
            width: 0, height: 0,) : SizedBox(width: 0, height: 0,),
        ],
      ),
    );
  }

  Widget MyWidget(QuestionAnswer questionanswer) {
    if (questionanswer.answer == '' || questionanswer.answer == null) {
      return SizedBox(width: 0, height: 0,);
    } else {
      return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(questionanswer.question
              , style: TextStyle(color: Colors.black, fontSize: 16),),
            SizedBox(height: 10,),
            Text(questionanswer.answer
              , style: TextStyle(color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),)
          ],
        ),
      );
    }
  }

  Widget MyImage(Gallery gallery_list, BuildContext context) {
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


