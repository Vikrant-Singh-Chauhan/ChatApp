import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future addUser(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .set(userInfoMap);
  }

  Future addMassage(String chatRooms, String massageId,
      Map<String, dynamic> massageInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("chatRooms"
        "")
        .doc(massageId)
        .collection("chats")
        .doc(massageId)
        .set(massageInfoMap);
  }

  Future updateLastMessageSend(
      String chatroomId, Map<String, dynamic> lastMassageInfo) async {
    return await FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatroomId)
        .update(lastMassageInfo);
  }

  Future<QuerySnapshot> Search(String username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("SearchKey", isEqualTo: username.substring(0, 1).toUpperCase())
        .get();
  }

  creatChatRoom(String chatRoomId, Map<String, dynamic> chatroomInfoMap) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .get();
    if (snapshot.exists) {
      return true;
    } else {
      return FirebaseFirestore.instance
          .collection("chatRooms")
          .doc(chatRoomId)
          .set(chatroomInfoMap);
    }
  }
}
