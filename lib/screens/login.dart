import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/modules/auth_service.dart';
import 'package:flutter_chat_app/modules/database.dart';
import 'package:flutter_chat_app/screens/home_screen.dart';
import 'package:flutter_chat_app/screens/signup.dart';
import 'package:flutter_chat_app/helper/sharedpref_helper.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();

  AuthenticationService _auth = new AuthenticationService();
  DatabaseManager databaseManager = new DatabaseManager();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  QuerySnapshot snapshotUserInfo;

  void signIn() async {
    if (_key.currentState.validate()) {
      SharedPreferenceHelper.saveUserEmail(_emailController.text);

      await _auth
          .login(_emailController.text, _passwordController.text)
          .then((result) async {
        if (result != null) {
          SharedPreferenceHelper.saveUserLoggedIn(true);
          databaseManager.getUserByEmail(_emailController.text).then((val) {
            snapshotUserInfo = val;

            SharedPreferenceHelper.saveUserName(
                snapshotUserInfo.docs[0].data()["name"]);

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          });
        }
      });
    }
  }

  // void signInUser() async {
  //   dynamic authResult =
  //       await _auth.loginUser(_emailContoller.text, _passwordController.text);
  //   if (authResult == null) {
  //     print('Sign in error. could not be able to login');
  //   } else {
  //     _emailContoller.clear();
  //     _passwordController.clear();
  //     Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF80CBC4),
                    Color(0xFF4DB6AC),
                    Color(0xFF26A69A),
                    Color(0xFF009688),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ))),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 90.0,
                    ),
                    Form(
                        key: _key,
                        child: Column(
                          children: [
                            //email input
                            TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)
                                    ? null
                                    : "Please enter valid email.";
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade50,
                                        width: 1.0)),
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.white,
                                ),
                                hintText: 'Enter your email',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade100),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            //password input
                            TextFormField(
                              obscureText: true,
                              // onChanged: (value) {
                              //   setState(() {
                              //     _password = value.trim();
                              //   });
                              // },
                              controller: _passwordController,
                              validator: (value) {
                                return value.isEmpty || value.length < 6
                                    ? "Please enter a password with at least 6 characters."
                                    : null;
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0)),
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                hintText: 'Enter your password',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade100),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 30.0),
                    MaterialButton(
                      elevation: 0,
                      minWidth: double.maxFinite,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        signIn();
                      },
                      color: Colors.white,
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Color(0xFF009688),
                          letterSpacing: 2.0,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account yet?",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[200],
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 0.0),
                            child: Text("Sign up here.",
                                style: TextStyle(
                                    fontSize: 13.5,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
