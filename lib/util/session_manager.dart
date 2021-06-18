import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/model/user.dart';
import 'package:lando/util/myconstant.dart';

class SessionManager {

  Future<void> startSession(User user) async{
    var session = FlutterSession();
    await session.set(MyConstant.SESSION_ID, user.id);
    await session.set(MyConstant.SESSION_FIREBASE_CHAT_ID, user.firebase_chatid);
    await session.set(MyConstant.SESSION_NAME, user.name);
    await session.set(MyConstant.SESSION_EMAIL, user.email);
    await session.set(MyConstant.SESSION_DOB, user.birth_date);
    await session.set(MyConstant.SESSION_PHONE, user.mobile);
    await session.set(MyConstant.SESSION_IMAGE, user.image);
    await session.set(MyConstant.SESSION_GENDER, user.gender);
    await session.set(MyConstant.SESSION_IS_LOGIN, true);
  }

}