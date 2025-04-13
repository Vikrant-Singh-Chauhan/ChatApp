import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future addUser(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .set(userInfoMap);
  }
}
