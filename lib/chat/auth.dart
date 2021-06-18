import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lando/chat/chatuser.dart';
import 'package:lando/model/response_model/response_destination_user.dart';
import 'package:lando/views/pages/chat_view.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ChatUser _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? ChatUser(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    print(email);
    print(password);
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      print('user id - '+user.uid );
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('sign in error' + e.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<FirebaseUser> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = new GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = await _auth.signInWithCredential(credential);
    FirebaseUser userDetails = result.user;

    if (result == null) {
    } else {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatView(user: DestinationUser(
      //   id: 0,image: '',name: ''
      // ),)));
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
