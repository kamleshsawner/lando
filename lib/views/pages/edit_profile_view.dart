import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_profile_update.dart';
import 'package:lando/model/request_model/request_token.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/model/response_model/response_myprofile.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/full_image_view.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';
import 'package:lando/views/widget/gradient_button.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {

  static var TYPE_PROFILE = 0;
  static var TYPE_GALLERY = 1;

  var _scaffold_key = GlobalKey<ScaffoldState>();
  var _form_key = GlobalKey<FormState>();
  var is_loading = true;
  var is_loading_update = false;
  ResponseMyProfile get_response;
  RequestProfileUpdate requestProfileUpdate;

  DateTime dateofbirth;

  File _imageprofile = null;
  File _imagegallery = null;

  _openCamera(int type) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 70);
    this.setState(() {
      if(type == TYPE_PROFILE){
        _imageprofile = picture;
      }else{
        _imagegallery = picture;
        addGallery();
      }
    });
  }

  _openGallery(int type) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 70);
    this.setState(() {
      if(type == TYPE_PROFILE){
        _imageprofile = picture;
      }else{
        _imagegallery = picture;
        addGallery();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    dateofbirth = DateTime.now();
    requestProfileUpdate = RequestProfileUpdate();
    Utility().checkInternetConnection().then((internet) => {
      if (internet){
        getData(),
      }
    });
  }

  // get data
  Future<Null> getData() async {
    await FlutterSession().get(MyConstant.SESSION_ID).then((token) => {
      APIServices().getuserProfile(RequestToken(user_id: token.toString())).then((dest_value) => {
        get_response = dest_value,
        setState(() {
          is_loading = false;
          is_loading_update = false;
        }),
      })
    });
  }

  _getdobDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dateofbirth,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != dateofbirth)
      setState(() {
        dateofbirth = picked;
      });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width / 4.5;

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
                    'Edit Profile',
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
            is_loading ? CenterCircleIndicator() : Container(
              margin: EdgeInsets.only(top: 75),
              child: Form(
                key: _form_key,
                child: ListView(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        showModalBottomSheet(
                            context: context, builder: ((builder) => bottomSheet(TYPE_PROFILE)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _imageprofile != null ? CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(File(_imageprofile.path)),
                          ) :get_response.user.image == '' ? ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Image.asset(
                              MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE,
                              width: 120.0,
                              height: 120.0,
                              fit: BoxFit.fill,
                            ),
                          ) :
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(Utility.getCompletePath(get_response.user.image),),
                                    fit: BoxFit.fill)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FullImageView()));
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage(
                                  image: NetworkImage(get_response.gallery_list != null &&
                                  get_response.gallery_list.length > 1
                                      ? Utility.getCompletePath(get_response.gallery_list[0].image) : ''),
                                  placeholder: AssetImage(MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE),
                                  height: size,
                                  fit: BoxFit.fill,
                                  width: size,
                                )
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FullImageView()));
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage(
                                  image: NetworkImage(get_response.gallery_list != null &&
                                      get_response.gallery_list.length > 2
                                      ?Utility.getCompletePath(get_response.gallery_list[1].image) : ''),
                                  placeholder: AssetImage(MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE),
                                  height: size,
                                  fit: BoxFit.fill,
                                  width: size,
                                )
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FullImageView()));
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage(
                                  image: NetworkImage(get_response.gallery_list != null &&
                                      get_response.gallery_list.length > 3
                                      ? Utility.getCompletePath(get_response.gallery_list[2].image) : ''),
                                  placeholder: AssetImage(MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE),
                                  height: size,
                                  fit: BoxFit.fill,
                                  width: size,
                                )
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              showModalBottomSheet(
                                  context: context, builder: ((builder) => bottomSheet(TYPE_GALLERY)));
                            },
                            child: Container(
                              width: size,
                              height: size,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Icon(
                                Icons.add_circle,
                                color: Colors.redAccent,
                                size: 45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: get_response.user.name,
                        validator: (name){
                          requestProfileUpdate.name = name;
                          if(name.isEmpty){
                            return 'Please enter name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hintText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                width: 1,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: get_response.user.email,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                width: 1,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: get_response.user.mobile,
                        keyboardType: TextInputType.phone,
                        validator: (mobile){
                          requestProfileUpdate.mobile = mobile;
                          if(mobile.isEmpty){
                            return 'Please enter Mobile number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hintText: 'Phone Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                width: 1,
                              )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _getdobDate(),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text( getDob() ,style: TextStyle(fontSize: 16,color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.all(15),
                      child: Text('Question',style: TextStyle(color: Colors.white),),
                    ),
                    Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('what should be your idea first date ?',style: TextStyle(color: Colors.white,fontSize: 18),),
                                SizedBox(height: 10,),
                                Text('Tried and true a casual dinner',style: TextStyle(color: Colors.black87,fontSize: 20,),)
                              ],
                            ),
                          ),
                          Icon(Icons.navigate_next,size: 50,color: Colors.black87,)
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(30,20,30,20),
                        child: MyGradientButton(
                          child: Text('Edit Answer',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),),
                          gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_DARK,MyColors.COLOR_PRIMARY_DARK,]),
                          height: 45,
                          onPressed: (){
                            },
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(30,10,30,20),
                        child: MyGradientButton(
                          child: Text('Update Profile',style: TextStyle(fontSize: 18,color: MyColors.COLOR_PRIMARY_DARK,fontWeight: FontWeight.w400),),
                          gradient: LinearGradient(colors: [Colors.white,Colors.white,]),
                          height: 45,
                          onPressed: (){
                            updateData();
                            },
                        )),
                  ],
                ),
              ),
            ),
            is_loading_update ? CenterCircleIndicator() :Text('')
          ],
        ),
      ),
    );
  }

  Future<Null> updateData() async {
    final isValid = _form_key.currentState.validate();
    if(!isValid){
      return;
    }
    if(!checkDob()){
      return;
    }else{
      setState(() {
        is_loading_update = true;
      });
      requestProfileUpdate.image = _imageprofile;
      requestProfileUpdate.email = get_response.user.email;
      requestProfileUpdate.name = get_response.user.name;
      requestProfileUpdate.dob = getDob();

      await FlutterSession().get(MyConstant.SESSION_ID).then((token) => {
        requestProfileUpdate.user_id = token.toString(),
        APIServices().updateProfile(requestProfileUpdate)
            .then((response) => {
        Utility.showToast(response.message),
          refreshPage(),
            })
      });
    }
  }

  Future<Null> addGallery() async {
    if(_imagegallery != null){
      setState(() {
        is_loading_update = true;
      });
      await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
        APIServices().addGallery(userid.toString(),_imagegallery)
            .then((response) => {
              _imagegallery = null,
          Utility.showToast(response.message),
          refreshPage(),
        })
      });
    }
  }

  Future<Null> refreshPage() async {
    getData();
  }

  // bottom sheet
  Widget bottomSheet(int type) {
    return Container(
      height: 100,
      width: MediaQuery.of(this.context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile Photo',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _openCamera(type);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              FlatButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _openGallery(type);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Gallery')),
            ],
          )
        ],
      ),
    );
  }

  String getDob() {
    if(get_response.user.birth_date == ''){
      if(Utility.getFormatedDate(dateofbirth) == Utility.getFormatedDate(DateTime.now())){
        return 'Select Date Of Birth';
      }else{
        return Utility.getFormatedDate(dateofbirth);
      }
    }else{
      return get_response.user.birth_date;
    }
  }

   bool checkDob() {
    if(getDob() == 'Select Date Of Birth'){
      Utility.showToast('Please select date of birth');
      return false;
    }
    return true;
   }

}
