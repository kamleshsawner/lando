import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lando/model/request_model/request_accept_reject.dart';
import 'package:lando/model/request_model/request_alluserprofile.dart';
import 'package:lando/model/request_model/request_changepass.dart';
import 'package:lando/model/request_model/request_check_friendship.dart';
import 'package:lando/model/request_model/request_contactus.dart';
import 'package:lando/model/request_model/request_create_password.dart';
import 'package:lando/model/request_model/request_destination_users.dart';
import 'package:lando/model/request_model/request_forgot.dart';
import 'package:lando/model/request_model/request_login.dart';
import 'package:lando/model/request_model/request_otp_verify.dart';
import 'package:lando/model/request_model/request_profile_update.dart';
import 'package:lando/model/request_model/request_selectdestination.dart';
import 'package:lando/model/request_model/request_selectpackage.dart';
import 'package:lando/model/request_model/request_sendrequest.dart';
import 'package:lando/model/request_model/request_signup.dart';
import 'package:lando/model/request_model/request_social_login.dart';
import 'package:lando/model/request_model/request_submitanswer.dart';
import 'package:lando/model/request_model/request_token.dart';
import 'package:lando/model/request_model/request_user_report.dart';
import 'package:lando/model/response_model/response_all_profile.dart';
import 'package:lando/model/response_model/response_destination.dart';
import 'package:lando/model/response_model/response_destination_user.dart';
import 'package:lando/model/response_model/response_forgotpassword.dart';
import 'package:lando/model/response_model/response_friend_req_list.dart';
import 'package:lando/model/response_model/response_login.dart';
import 'dart:convert';

import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/model/response_model/response_myprofile.dart';
import 'package:lando/model/response_model/response_package.dart';
import 'package:lando/model/response_model/response_question.dart';
import 'package:lando/model/response_model/response_send_request.dart';
import 'package:lando/model/user.dart';

class APIServices {

  static const String BASE_URL = "https://lando.wrappex.com/api/";
  static const String BASE_PROFILE_IMAGE_URL = "https://lando.wrappex.com/storage/";

  // profile apis
  static const String API_SIGNUP = BASE_URL + 'signup';
  static const String API_LOGIN = BASE_URL + 'login';
  static const String API_SOCIAL_LOGIN = BASE_URL + 'social-login';
  static const String API_FORGOT = BASE_URL + 'forgot-password';
  static const String API_FORGOT_OTP = BASE_URL + 'verify-otp';
  static const String API_FORGOT_CREATE_PASS = BASE_URL + 'reset-password';
  static const String API_VIEW_PROFILE = BASE_URL + 'view-profile';
  static const String API_VIEW_OTHER_PROFILE = BASE_URL + 'get-user-profile';
  static const String API_UPDATE_PROFILE = BASE_URL + 'update-profile';
  static const String API_ADD_GALLERY = BASE_URL + 'add-gallery-image';

  // friendship
  static const String API_CHECK_FRIENDSHIP = BASE_URL + 'check-friendship';
  static const String API_SEND_FRIENDSHIP = BASE_URL + 'send-request';
  static const String API_SEND_REQUEST_LIST = BASE_URL + 'friend-request-list';
  static const String API_FRIENDS_LIST = BASE_URL + 'friend-list';
  static const String API_REQUEST_ACCEPT_REJECT = BASE_URL + 'request-accept-reject';
  static const String API_ALL_USER_PROFILE = BASE_URL + 'get-userlist';
  static const String API_CACNEL_FRIEND = BASE_URL + 'cancel-user';

  // block user
  static const String API_BLOCK_UNBLOCK_USER = BASE_URL + 'block-unblock-user';
  static const String API_REPORT_USER = BASE_URL + 'report-user';
  static const String API_BLOCK_USER_LIST = BASE_URL + 'block-user-list';
  static const String API_DELETE_ACCOUNT = BASE_URL + 'delete-account';


  // QUESTION
  static const String API_QUESTIONS = BASE_URL + 'question';
  static const String API_SUBMIT_ANSWER = BASE_URL + 'Submit-answer';

  // package
  static const String API_PACKAGE = BASE_URL + 'package';
  static const String API_PACKAGE_SELECTION = BASE_URL + 'select-package';

  // destination
  static const String API_DESTINATION = BASE_URL + 'gruops';
  static const String API_DESTINATION_SELECT = BASE_URL + 'select-group';
  static const String API_DESTINATION_USERS = BASE_URL + 'group-user-list';

   // other
  static const String API_CONTACT_US = BASE_URL + 'contact-us';
  static const String API_CHANGE_PASSWORD = BASE_URL + 'update-password';



  // login api
  Future<ResponseLogin> userLogin(RequestLogin requestLogin) async {
    print(requestLogin.tojson().toString());
    final response = await postCall(path: API_LOGIN, parameters: requestLogin.tojson());
    return ResponseLogin.fromjson(json.decode(response.body), response.statusCode);
  }

  // SOCAIL login api
  Future<ResponseLogin> userSocialLogin(RequestSocialLogin requestSocialLogin) async {
    print(requestSocialLogin.tojson().toString());
    final response = await postCall(path: API_SOCIAL_LOGIN, parameters: requestSocialLogin.tojson());
    print(response.body.toString());
    return ResponseLogin.fromjson(json.decode(response.body), response.statusCode);
  }

    // forgot password api
  Future<ResponseForgotPassword> userForgotPassword(RequestForgot requestforgot) async {
    print(requestforgot.tojson().toString());
    final response = await postCall(path: API_FORGOT, parameters: requestforgot.tojson());
    print(response.body.toString());
    return ResponseForgotPassword.fromjson(json.decode(response.body), response.statusCode);
  }

  // verify otp api
  Future<ResponseMessage> verifyOTP(RequestOTPVerify requestotpverify) async {
    final response = await postCall(path: API_FORGOT_OTP, parameters: requestotpverify.tojson());
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // create password api
  Future<ResponseMessage> createNewPassword(RequestCreatePassword requestcreatepassword) async {
    final response = await postCall(path: API_FORGOT_CREATE_PASS, parameters: requestcreatepassword.tojson());
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // signup api
  Future<ResponseLogin> userSignup(RequestSignup requestSignup) async {
    print(requestSignup.tojson().toString());
    final response = await postCall(path: API_SIGNUP, parameters: requestSignup.tojson());
    print(response.body);
    return ResponseLogin.fromjson(json.decode(response.body), response.statusCode);
  }

  // get profile api
  Future<ResponseMyProfile> getuserProfile(RequestToken requestToken) async {
    List<Gallery> gallery_list = null;
    List<QuestionAnswer> quesans_list = null;
    final response = await postCall(path: API_VIEW_PROFILE, parameters: requestToken.tojson_id());
    var data = json.decode(response.body);
    print(data.toString());
    var user = User.fromjson(data['users']);
    var list_array = data['gallary'] as List;
    var ques_list_array = data['user_questions'] as List;
    if(list_array.length>0){
      gallery_list = list_array.map((myobject) => Gallery.fromjson(myobject)).toList();
    }
    if(ques_list_array.length>0){
      quesans_list = ques_list_array.map((myobject) => QuestionAnswer.fromjson(myobject)).toList();
    }
    if(response.statusCode == 200){
      return ResponseMyProfile(status: response.statusCode,message: data['message'],user: user,gallery_list: gallery_list,
      qus_ans_list: quesans_list);
    }else{
      return ResponseMyProfile(status: response.statusCode,message: data['message'],user: null,gallery_list: null,
          qus_ans_list: quesans_list);
    }
  }

  // forgot api
  Future<ResponseMessage> getPassword(RequestForgot requestForgot) async {
    print(requestForgot.tojson().toString());
    final response = await postCall(path: API_FORGOT, parameters: requestForgot.tojson());
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // forgot - orp verify api
  Future<ResponseMessage> otpVerifyPassword(RequestOTPVerify requestotpverify) async {
    print(requestotpverify.tojson().toString());
    final response = await postCall(path: API_FORGOT_OTP, parameters: requestotpverify.tojson());
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // forgot - create pass api
  Future<ResponseMessage> createPassword(RequestCreatePassword requestcreatepassword) async {
    print(requestcreatepassword.tojson().toString());
    final response = await postCall(path: API_FORGOT_CREATE_PASS, parameters: requestcreatepassword.tojson());
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // contact us
  Future<ResponseMessage> contactUs(RequestContactUs requestcontact) async {
    print(requestcontact.tojson().toString());
    final response = await postCall(path: API_CONTACT_US, parameters: requestcontact.tojson());
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // change password
  Future<ResponseMessage> changePassword(RequestChangePass requestchangepass) async {
    print(requestchangepass.tojson().toString());
    final response = await postCall(path: API_CHANGE_PASSWORD, parameters: requestchangepass.tojson());
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // CHECK FRIENDSHIP
  Future<ResponseMessage> checkFriendshipStatus(RequestCheckFriendship requestcheckfriendship) async {
    print(API_CHECK_FRIENDSHIP);
    print(requestcheckfriendship.tojson().toString());
    final response = await postCall(path: API_CHECK_FRIENDSHIP, parameters: requestcheckfriendship.tojson());
    print(response.body);
    return ResponseMessage.fromjsonforstatus(json.decode(response.body), response.statusCode);
  }


  // CHECK other user profile
  Future<ResponseSendRequest> checkOtherUserProfile(RequestCheckFriendship requestcheckfriendship) async {
    List<QuestionAnswer> quesans_list = null;
    List<UserGallery> gallery_list = null;
    print(API_VIEW_OTHER_PROFILE);
    print(requestcheckfriendship.tojson().toString());
    final response = await postCall(path: API_VIEW_OTHER_PROFILE, parameters: requestcheckfriendship.tojson());
    print(response.body);
    var data = json.decode(response.body);
    if(response.statusCode == 200){
      var ques_list_array = data['question'] as List;
      var gallery_list_array = data['user_gallery'] as List;
      if(ques_list_array.length>0){
        quesans_list = ques_list_array.map((myobject) => QuestionAnswer.fromjson(myobject)).toList();
      }
      if(gallery_list_array.length>0){
        gallery_list = gallery_list_array.map((myobject) => UserGallery.fromjson(myobject)).toList();
      }
      return ResponseSendRequest(status: response.statusCode,message: data['message'],list_ques_ans: quesans_list,gallery_list: gallery_list);
    }else{
      return ResponseSendRequest(status: response.statusCode,message: data['message'],list_ques_ans: null,gallery_list: null);
    }
  }

  // block unblock user
  Future<ResponseMessage> blockUnblockUser(RequestCheckFriendship requestcheckfriendship) async {
    print( API_BLOCK_UNBLOCK_USER);
    print(requestcheckfriendship.tojson().toString());
    final response = await postCall(path: API_BLOCK_UNBLOCK_USER, parameters: requestcheckfriendship.tojson());
    print(response.body);
    return ResponseMessage.fromjsonforstatus(json.decode(response.body), response.statusCode);
  }

  // REPORT user
  Future<ResponseMessage> reportUser(RequestReportUser requestreportuser) async {
    print( API_REPORT_USER);
    print(requestreportuser.tojson().toString());
    final response = await postCall(path: API_REPORT_USER, parameters: requestreportuser.tojson());
    print(response.body);
    return ResponseMessage.fromjsonforstatus(json.decode(response.body), response.statusCode);
  }

    // delete account
  Future<ResponseMessage> deleteAccount(RequestToken requesttoken) async {
    print( API_DELETE_ACCOUNT);
    print(requesttoken.tojson_userid().toString());
    final response = await postCall(path: API_DELETE_ACCOUNT, parameters: requesttoken.tojson_userid());
    print(response.body);
    return ResponseMessage.fromjsonforstatus(json.decode(response.body), response.statusCode);
  }


  // CANCEL FRIEND PROFILE
  Future<ResponseMessage> cancelFriendProfile(RequestCheckFriendship requestcancelfriend) async {
    print(requestcancelfriend.tojson().toString());
    final response = await postCall(path: API_CACNEL_FRIEND, parameters: requestcancelfriend.tojson());
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // SEND FRIEND REQUEST
  Future<ResponseMessage> sendFriendRequest(RequestSendRequest requestsendrequest) async {
    print(requestsendrequest.tojson().toString());
    final response = await postCall(path: API_SEND_FRIENDSHIP, parameters: requestsendrequest.tojson());
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // select package
  Future<ResponseMessage> selectPackage(RequestSelectPackage requestselectPackage) async {
    print(requestselectPackage.tojson().toString());
    final response = await postCall(path: API_PACKAGE_SELECTION, parameters: requestselectPackage.tojson());
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // get all user profile from group id and user id
  Future<ResponseAllProfile> getAllUserProfile(RequestAallUserProfile requestAallUserProfile) async {
    print(API_ALL_USER_PROFILE+requestAallUserProfile.tojson().toString());
    final response = await postCall(path: API_ALL_USER_PROFILE, parameters: requestAallUserProfile.tojson());
    print(response.body);
    print(response.statusCode.toString());
    if(response.statusCode == 200){
      var list = List<UserProfile>();
      var data = json.decode(response.body);
      var data_array = data['data'] as List;
      if(data_array.length>0){
        list = data_array.map((myobject) => UserProfile.fromjson(myobject)).toList();
      }
      return ResponseAllProfile(status: response.statusCode,message: '',list_profiles: list);
    }else{
      return ResponseAllProfile(status: response.statusCode,message: 'No User Available',list_profiles: null);
    }
  }

  // request accept reject
  Future<ResponseMessage> requestAcceptReject(RequestAcceptReject requestacceptreject) async {
    print(requestacceptreject.tojson().toString());
    final response = await postCall(path: API_REQUEST_ACCEPT_REJECT, parameters: requestacceptreject.tojson());
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // select destination
  Future<ResponseMessage> selectDestination(RequestSelectDestination requestselectDestination) async {
    print(requestselectDestination.tojson().toString());
    final response = await postCall(path: API_DESTINATION_SELECT, parameters: requestselectDestination.tojson());
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // submitAnswer
  Future<ResponseMessage> submitAnswer(RequestSubmitAnswer requestsubmitnaswer) async {
    print(requestsubmitnaswer.tojson().toString());
    final response = await postCall(path: API_SUBMIT_ANSWER, parameters: requestsubmitnaswer.tojson());
    print(response.body);
    return ResponseMessage.fromjson(json.decode(response.body), response.statusCode);
  }

  // get destination
  Future<ResponseDestination> getDestination(int userid) async {
    print('user id $userid');
    final response = await postCall(path: API_DESTINATION,parameters: RequestToken(user_id: userid.toString()).tojson_user_id());
    print(RequestToken(user_id: userid.toString()).tojson_user_id().toString());
    var response_data = jsonDecode(response.body);
    if(response.statusCode == 200){
      var list_array = response_data['groups'] as List;
      List<Destination> list = list_array.map((myobject) => Destination.fromjson(myobject)).toList();
      return ResponseDestination(status: response.statusCode,message: response_data['message'],dest_list: list);
    }else{
      return ResponseDestination(status: response.statusCode,message: response_data['message'],dest_list: null);
    }
  }

  // get FRIEND REQUES LIST
  Future<ResponseFriendReqList> getFriendRequestList(RequestToken requestToken) async {
    final response = await postCall(path: API_SEND_REQUEST_LIST,parameters: requestToken.tojson_userid());
    var response_data = jsonDecode(response.body);
    if(response.statusCode == 200){
      var list_array = response_data['users'] as List;
      List<ReqUser> list = list_array.map((myobject) => ReqUser.fromjson(myobject)).toList();
      return ResponseFriendReqList(status: response.statusCode,message: response_data['message'],user_list: list);
    }else{
      return ResponseFriendReqList(status: response.statusCode,message: response_data['message'],user_list: null);
    }
  }

  // get block user LIST
  Future<ResponseFriendReqList> getBlockUserList(RequestToken requestToken) async {
    print(API_BLOCK_USER_LIST);
    print(requestToken.tojson_userid());
    final response = await postCall(path: API_BLOCK_USER_LIST,parameters: requestToken.tojson_userid());
    var response_data = jsonDecode(response.body);
    print(response_data.toString());
    if(response.statusCode == 200){
      var list_array = response_data['users'] as List;
      List<ReqUser> list = list_array.map((myobject) => ReqUser.fromjsonforfriendsforblockuser(myobject)).toList();
      return ResponseFriendReqList(status: response.statusCode,message: response_data['message'],user_list: list);
    }else{
      return ResponseFriendReqList(status: response.statusCode,message: response_data['message'],user_list: null);
    }
  }

  // get FRIENDS LIST
  Future<ResponseFriendReqList> getFriendList(RequestToken requestToken) async {
    final response = await postCall(path: API_FRIENDS_LIST,parameters: requestToken.tojson_userid());
    var response_data = jsonDecode(response.body);
    print(jsonDecode(response.body).toString());
    if(response.statusCode == 200){
      var list_array = response_data['users'] as List;
      List<ReqUser> list = list_array.map((myobject) => ReqUser.fromjsonforfriends(myobject)).toList();
      return ResponseFriendReqList(status: response.statusCode,message: response_data['message'],user_list: list);
    }else{
      return ResponseFriendReqList(status: response.statusCode,message: response_data['message'],user_list: null);
    }
  }

  // get destination USERS
  Future<ResponseDestinationUsers> getDestinationUsers(RequestDestinationUsers requestDestinationUsers,String userid) async {
    final response = await postCall(path: API_DESTINATION_USERS,parameters: requestDestinationUsers.tojson());
    var response_data = jsonDecode(response.body);
    if(response.statusCode == 200){
      var list_array = response_data['users'] as List;
      List<DestinationUser> list = List<DestinationUser>();
      for(int i=0;i<list_array.length;i++){
        var user = DestinationUser.fromjson(list_array[i]);
        if(user.id.toString() != userid){
          list.add(user);
        }
      }
      return ResponseDestinationUsers(status: response.statusCode,message: response_data['message'],user_list:  list);
    }else{
      return ResponseDestinationUsers(status: response.statusCode,message: response_data['message'],user_list: null);
    }
  }

  // get package
  Future<ResponsePackage> getPackage() async {
    final response = await get_apirequest(path: API_PACKAGE);
    var response_data = jsonDecode(response.body);
    if(response.statusCode == 200){
      var list_array =  response_data['Packages'] as List;
      List<Package> list = list_array.map((e) => Package.fromjson(e)).toList();
      return ResponsePackage(status: response.statusCode,message: response_data['message'],pack_list: list);
    }else{
      return ResponsePackage(status: response.statusCode,message: response_data['message'],pack_list: null);
    }
  }

  // get questions
  Future<ResponseQuestions> getQuestions() async {
    final response = await get_apirequest(path: API_QUESTIONS);
    var response_data = jsonDecode(response.body);
    print(response_data.toString());
    if(response.statusCode == 200){
      var list_array = response_data['questions'] as List;
      List<Question> list = list_array.map((myobject) => Question.fromjson(myobject)).toList();
      return ResponseQuestions(status: response.statusCode,message: response_data['message'],ques_list: list);
    }else{
      return ResponseQuestions(status: response.statusCode,message: response_data['message'],ques_list: null);
    }
  }

  // post api request without token
  Future<http.Response> postCall(
      {@required String path,
        @required Map<String, dynamic> parameters}) async {
    final result = await http.post(path,
        headers: header(),
        encoding: Encoding.getByName("utf-8"),
        body: parameters);
    return result;
  }

  // MULTIPART - PROFILE UPDATE
  Future<ResponseMessage> updateProfile(RequestProfileUpdate requestProfileUpdate) async{
    var request = http.MultipartRequest('POST', Uri.parse(API_UPDATE_PROFILE),);
    if(requestProfileUpdate.image != null ){
      request.files.add(await http.MultipartFile.fromPath('profile', requestProfileUpdate.image.path));
    }
    request.fields['email'] = requestProfileUpdate.email;
    request.fields['name'] = requestProfileUpdate.name;
    request.fields['phone'] = requestProfileUpdate.mobile;
    request.fields['dob'] = requestProfileUpdate.dob;
    request.fields['user_id'] = requestProfileUpdate.user_id;
    var stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);
    var res_body = jsonDecode(response.body);
    print(res_body.toString());
    return ResponseMessage(status: response.statusCode,message:res_body['message']);
  }

  // MULTIPART - gallery add
  Future<ResponseMessage> addGallery(String user_id,File file) async{
    var request = http.MultipartRequest('POST', Uri.parse(API_ADD_GALLERY),);
    if(file != null ){
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
    }
    request.fields['userid'] = user_id;
    var stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);
    var res_body = jsonDecode(response.body);
    return ResponseMessage(status: response.statusCode,message:res_body['message']);
  }

  // post api request with token
  Future<http.Response> postTokenCall(
      {@required String path,
        @required Map<String, dynamic> parameters,
        @required String token}) async {
    final result = await http.post(path,
        headers: tokenHeader(token),
        encoding: Encoding.getByName("utf-8"),
        body: parameters);
    return result;
  }

  // get api request
  Future<http.Response> get_apirequest(
      {@required String path}) async {
    final result = await http.get(path);
    return result;
  }


  // api header
  Map<String, String> header() => {
    "X-Requested-With": "XMLHttpRequest",
    "Content-Type": "application/x-www-form-urlencoded"
  };

  // api token header
  Map<String, String> tokenHeader(String token) => {
    "X-Requested-With": "XMLHttpRequest",
    "Authorization": "Bearer $token",
    "Content-Type": "application/x-www-form-urlencoded"
  };

}
