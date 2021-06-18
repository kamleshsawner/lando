
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lando/chat/auth.dart';
import 'package:lando/chat/database.dart';
import 'package:lando/model/user.dart';

class MyFirebaseAuth {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // firebase sign-up
  Future<bool> firebaseSignUp(User myuser, String token) async {
    DatabaseMethods databaseMethods = new DatabaseMethods();
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: myuser.email,
      password: myuser.email,
    )).user;
    if (user != null) {
      Map<String,String> userDataMap = {
        "userId" : myuser.id.toString(),
        "chatId" : myuser.firebase_chatid,
        "userName" : myuser.name,
        "userEmail" : myuser.email,
        "userImage" : '',
        "firebaseToken" : token,
        "message_count" : '0'
      };
      print('user info - '+userDataMap.toString());
      databaseMethods.UserSignupData(userDataMap,myuser.firebase_chatid);
      return true;
    } else {
      return false;
    }
  }

  // firebase sigin-in
  Future<bool> firebaseSignin(User myuser) async {
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: myuser.email,
      password: myuser.email,
    )).user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

}