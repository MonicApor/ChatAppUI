import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/sharedpref_helper.dart';
import 'package:flutter_chat_app/helper/constants.dart';
import 'package:flutter_chat_app/modules/database.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';
import 'package:flutter_chat_app/screens/login.dart';
import 'package:flutter_chat_app/modules/auth_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  AuthenticationService _auth = new AuthenticationService();
  DatabaseManager databaseManager = new DatabaseManager();

  Stream conversationStream;
  Stream searchStream;
  String myName, myEmail;
  bool isSearching = false;

  TextEditingController searchController = new TextEditingController();

  search() async {
    isSearching = true;
    setState(() {});
    searchStream = await databaseManager.getUserByName(searchController.text);
  }

  getConversationID(String x, String y) {
    if (x.substring(0, 1).codeUnitAt(0) > y.substring(0, 1).codeUnitAt(0)) {
      return "$x\_$y";
    } else {
      return "$y\_$x";
    }
  }

  getConversations() async {
    conversationStream =
        await databaseManager.getConversations(Constants.myName);
    setState(() {});
  }

  getUserInfo() async {
    Constants.myName = await SharedPreferenceHelper.getUserName();
    databaseManager.getConversations(Constants.myName).then((val) {
      setState(() {
        conversationStream = val;
      });
    });
    setState(() {});
  }

  launch() async {
    getUserInfo();
    getConversations();
  }

  @override
  void initState() {
    launch();
    super.initState();
  }

  Widget searchResult(String name, String email) {
    return Container(
        margin: EdgeInsets.only(bottom: 5.0, right: 10.0, left: 10.0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: GestureDetector(
            onTap: () {
              if (name != Constants.myName) {
                var conversationID = getConversationID(name, Constants.myName);
                Map<String, dynamic> conversationMap = {
                  "users": [name, Constants.myName],
                  "conversationID": conversationID,
                };

                databaseManager.createChat(conversationID, conversationMap);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChatScreen(name, conversationID)));
              } else {
                print("Cannot search yourself");
              }
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    CircleAvatar(
                        backgroundColor: Color(0xFF26A69A),
                        radius: 16.0,
                        child: Icon(Icons.person, color: Colors.white)),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16.0,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.50,
                            child: Text(
                              email,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ])
                  ]),
                ])));
  }

  Widget searchList() {
    return StreamBuilder(
        stream: searchStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return searchResult(
                        snapshot.data.docs[index].data()["name"],
                        snapshot.data.docs[index].data()["email"]);
                  },
                )
              : Container();
        });
  }

  Widget conversationList() {
    return StreamBuilder(
      stream: conversationStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var test = snapshot.data.docs[index]
                      .data()["conversationID"]
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(Constants.myName, "");

                  return Chats(
                      snapshot.data.docs[index]
                          .data()["conversationID"]
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, ""),
                      snapshot.data.docs[index].data()["conversationID"]);
                })
            : Center(
                child: Text(
                "No conversations yet.",
                style: TextStyle(color: Colors.grey),
              ));
      },
    );
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
          ' Messages',
          style: TextStyle(color: Colors.white, fontSize: 22.0),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF80CBC4),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    onPressed: () {
                      SharedPreferenceHelper.saveUserLoggedIn(false);
                      _auth.signOut();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    iconSize: 20.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            Row(
              children: [
                isSearching
                    ? Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            isSearching = false;
                            searchController.text = "";
                            setState(() {});
                          },
                          child: Icon(Icons.arrow_back, color: Colors.grey),
                        ))
                    : Container(),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey[400],
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search username..."),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (searchController.text != "") {
                            if (searchController.text != Constants.myName) {
                              search();
                            } else {
                              print("cannot search self");
                            }
                          }
                        },
                        child: Icon(Icons.search, color: Colors.grey),
                      )
                    ],
                  ),
                ))
              ],
            ),
            isSearching ? searchList() : conversationList(),
          ],
        ),
      ),
    );
  }
}

class Chats extends StatelessWidget {
  final String userName;
  final String conversationID;
  Chats(this.userName, this.conversationID);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(userName, conversationID)));
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 5.0, right: 10.0, left: 10.0),
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF26A69A),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text("${userName.substring(0, 1).toUpperCase()}",
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                ),
                SizedBox(width: 10.0),
                Text(userName,
                    style: TextStyle(color: Colors.black87, fontSize: 16.0)),
              ],
            )));
  }
}
