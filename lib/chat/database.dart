import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  Future<void> UserSignupData(userData,chat_id) async {
    Firestore.instance.collection("users")
        .document(chat_id)
        .setData(userData).catchError((e) {
      print('firebase error - '+e.toString());
    });
  }


  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }


  Future<void> addMessage(String chatRoomId, chatMessageData,String friendchat_id){

    Firestore.instance.collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
          print(e.toString());
    });
  }

  Future<void> addFriend(String login_chat_id, userData,String friend_chat_id){
    Firestore.instance.collection("users")
        .document(login_chat_id)
        .collection("firends")
        .document(friend_chat_id)
        .setData(userData).catchError((e){
          print(e.toString());
    });
  }

  Future<void> acceptFriendStatus(String login_chat_id,String friend_chat_id) async{
    var collection = Firestore.instance.collection("users")
        .document(friend_chat_id)
        .collection("firends");
    await collection.document(login_chat_id).updateData(<String, dynamic>{
      'friend_status': '1',
    });
  }


  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  // searchByName(String searchField) {
  //   return Firestore.instance
  //       .collection("users")
  //       .where('userName', isEqualTo: searchField)
  //       .getDocuments();
  // }


  getChats(String chatRoomId) async{
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  getFriendlist(String chat_id) async{
    return Firestore.instance
        .collection("users")
        .document(chat_id)
        .collection("firends")
        .snapshots();
  }

  void updateFriendMessageCounte(String login_chat_id,String friend_chat_id,String value) async{

    Map<String, String> data = <String, String>{
      'message_count': value,
    };
    var collection = Firestore.instance.collection("users")
        .document(friend_chat_id)
        .collection("firends");
    await collection.document(login_chat_id).updateData(<String, dynamic>{
      'message_count': value,
    });
  }

  void updateMyMessageCounte(String login_chat_id,String friend_chat_id,String value) async{
    Map<String, String> data = <String, String>{
      'message_count': value,
    };
    var collection = Firestore.instance.collection("users")
        .document(login_chat_id)
        .collection("firends");
    await collection.document(friend_chat_id).updateData(<String, dynamic>{
      'message_count': value,
    });
  }

  getUserChatCount(String chatRoomId) async {
    return await Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId);
  }


  // getUserChats(String itIsMyName) async {
  //   return await Firestore.instance
  //       .collection("chatRoom")
  //       .where('users', arrayContains: itIsMyName)
  //       .snapshots();
  // }

}
