import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseManager {
  getUserByName(String name) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: name)
        .snapshots();
  }

  getUserByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
  }

  createUser(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  createChat(String conversationID, conversationMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("privateChat")
        .doc(conversationID)
        .get();
    if (snapShot.exists) {
      return true;
    } else {
      return FirebaseFirestore.instance
          .collection("privateChat")
          .doc(conversationID)
          .set(conversationMap);
    }
  }

  addMessages(String conversationID, messageMap) {
    FirebaseFirestore.instance
        .collection("privateChat")
        .doc(conversationID)
        .collection("chats")
        .add(messageMap);
  }

  getMessages(String conversationID) async {
    return await FirebaseFirestore.instance
        .collection("privateChat")
        .doc(conversationID)
        .collection("chats")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  getConversations(String name) async {
    return await FirebaseFirestore.instance
        .collection("privateChat")
        .where("users", arrayContains: name)
        .snapshots();
  }

  addChatRoom(privateChat, conversationID) {
    FirebaseFirestore.instance
        .collection("privateChat")
        .doc(conversationID)
        .set(privateChat);
  }

  getUserInfo(String name) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: name)
        .get();
  }
}
