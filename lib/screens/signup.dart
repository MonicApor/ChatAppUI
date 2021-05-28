//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/login.dart';
import 'package:flutter_chat_app/modules/auth_service.dart';
import 'package:flutter_chat_app/modules/database.dart';
import 'package:flutter_chat_app/helper/sharedpref_helper.dart';

// import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final _key = GlobalKey<FormState>();

  AuthenticationService _auth = new AuthenticationService();
  DatabaseManager databaseManager = new DatabaseManager();
  // SharedPreferenceHelper sharedPreferenceHelper = new SharedPreferenceHelper();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  // void createUser() async {
  //   dynamic result = await _auth.signUp(email, password)
  //       _nameController.text, _emailController.text, _passwordController.text);
  //   if (result == null) {
  //     print('Email is not valid');
  //   } else {
  //     print(result.toString());
  //     _nameController.clear();
  //     _passwordController.clear();
  //     _emailController.clear();
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => LoginScreen()));
  //   }
  // }

  void signUpValidate() {
    if (_key.currentState.validate()) {
      _auth.signUp(_emailController.text, _passwordController.text).then((val) {
        Map<String, String> userMap = {
          "email": _emailController.text,
          "name": _nameController.text
        };

        SharedPreferenceHelper.saveUserName(_nameController.text);
        SharedPreferenceHelper.saveUserEmail(_emailController.text);

        databaseManager.createUser(userMap);
        // SharedPreferenceHelper.saveUserLoggedIn(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        body: Stack(
          // key: _key,
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
                      'Sign Up',
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
                            //name input
                            TextFormField(
                              controller: _nameController,
                              validator: (value) {
                                return value.isEmpty || value.length < 6
                                    ? "Please enter a valid name with at least 6 characters."
                                    : null;
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
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintText: 'Enter your name',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade100),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
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
                        signUpValidate();
                      },
                      color: Colors.white,
                      child: Text(
                        'SIGN UP',
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
                        Text("Already have an account?",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[200],
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 0.0),
                            child: Text("Log in here.",
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

// class FirestoreAuth {
//   static var instance;
// }
