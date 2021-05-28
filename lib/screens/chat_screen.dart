import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_chat_app/helper/sharedpref_helper.dart';
import 'package:flutter_chat_app/helper/constants.dart';
import 'package:flutter_chat_app/modules/database.dart';
import 'package:flutter_chat_app/screens/home_screen.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String conversationID;
  ChatScreen(this.name, this.conversationID);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DatabaseManager databaseManager = new DatabaseManager();
  TextEditingController messageController = new TextEditingController();

  String conversationID = "";
  String myName, myEmail;
  Stream messageStream;

  getInfo() async {
    myName = await SharedPreferenceHelper.getUserName();
    myEmail = await SharedPreferenceHelper.getUserEmail();
    conversationID = getConversationID(widget.name, Constants.myName);
  }

  getConversationID(String x, String y) {
    if (x.substring(0, 1).codeUnitAt(0) > y.substring(0, 1).codeUnitAt(0)) {
      return "$x\_$y";
    } else {
      return "$y\_$x";
    }
  }

  getMessages() async {
    messageStream = await databaseManager.getMessages(conversationID);
    setState(() {});
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      String msg = messageController.text;
      var lastMsgTs = DateTime.now();
      Map<String, dynamic> messageMap = {
        "message": msg,
        "sender": Constants.myName,
        "timestamp": DateTime.now(),
      };
      databaseManager.addMessages(conversationID, messageMap);

      messageController.text = "";
    }
  }

  launch() async {
    await getInfo();
    getMessages();
  }

  @override
  void initState() {
    launch();
    super.initState();
  }

  Widget chatMessageList() {
    return StreamBuilder(
        stream: messageStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                        snapshot.data.docs[index].data()["message"],
                        snapshot.data.docs[index].data()["sender"] ==
                            Constants.myName);
                  })
              : Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF26A69A),
          brightness: Brightness.dark,
          elevation: 0.0,
          title: Text(
            widget.name, //receiver in chat
            style: TextStyle(color: Colors.white, fontSize: 18.5),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }),
        ),
        body: Container(
          child: Stack(
            children: [
              chatMessageList(),
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.black54,
                  padding: EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10.0),
                              hintText: "Send a message...",
                              hintStyle: TextStyle(
                                color: Colors.grey[200],
                                fontSize: 16,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 2.0),
                        child: IconButton(
                          onPressed: () {
                            sendMessage();
                          },
                          icon: Icon(Icons.send_sharp, color: Colors.white),
                          iconSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  ChatBubble(this.message, this.isSender);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: EdgeInsets.only(
          left: isSender ? 80.0 : 15.0, right: isSender ? 15.0 : 80.0),
      width: MediaQuery.of(context).size.width,
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        decoration: BoxDecoration(
            color: isSender ? Color(0xFF80CBC4) : Colors.grey[300],
            borderRadius: isSender
                ? BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
        child: Text(
          message,
          style: TextStyle(
              color: isSender ? Colors.white : Colors.black87, fontSize: 16.0),
        ),
      ),
    );
  }
}
