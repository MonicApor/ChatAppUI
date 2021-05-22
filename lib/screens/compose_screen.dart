import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/home_screen.dart';
// import 'package:flutter_chat_app/screens/chat_screen.dart';

class ComposeScreen extends StatefulWidget {
  @override
  ComposeScreenState createState() => ComposeScreenState();
}

class ComposeScreenState extends State<ComposeScreen> {
  var inputText = "";
  var _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF26A69A),
        brightness: Brightness.dark,
        elevation: 0.0,
        toolbarHeight: 70,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
        title: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(0.0),
                child: Row(children: [
                  Form(
                    // key: formKey,
                    child: Expanded(
                      child: TextFormField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (text) {
                            setState(() {
                              inputText = text;
                            });
                          },
                          // validator: (val) {
                          // return val.isEmpty
                          //     ? "Please Provide A Username"
                          //     : null;
                          // },
                          // controller: searchController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Send new message to...',
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 18,
                            ),
                            border: InputBorder.none,
                          )),
                    ),
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.search_rounded),
                    onPressed: () {
                      // initiateSearch();
                    },
                  )
                ]),
              ),
              // searchList(),
            ],
          ),
        ),
      ),
    );
  }
}
