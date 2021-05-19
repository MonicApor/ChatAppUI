import 'package:flutter/material.dart';
import 'package:flutter_chat_app/modules/auth_service.dart';
import 'package:flutter_chat_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  // final _key = GlobalKey<FormState>();

  final AuthenticationService _auth = AuthenticationService();

  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void signInUser() async {
    dynamic authResult =
        await _auth.loginUser(_emailContoller.text, _passwordController.text);
    if (authResult == null) {
      print('Sign in error. could not be able to login');
    } else {
      _emailContoller.clear();
      _passwordController.clear();
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  buildEmailInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextFormField(
            controller: _emailContoller,
            validator: (value) {
              if (value.isEmpty) {
                return 'Email cannot be empty';
              } else
                return null;
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide:
                      BorderSide(color: Colors.grey.shade50, width: 1.0)),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.mail,
                color: Colors.white,
              ),
              hintText: 'Enter your email',
              hintStyle: TextStyle(color: Colors.grey.shade100),
            ),
          ),
        ),
      ],
    );
  }

  buildPasswordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextFormField(
            controller: _passwordController,
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Password cannot be empty';
              } else
                return null;
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.white, width: 1.0)),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your password',
              hintStyle: TextStyle(color: Colors.grey.shade100),
            ),
          ),
        ),
      ],
    );
  }

  buildLoginBtn() {
    return MaterialButton(
      elevation: 0,
      minWidth: double.maxFinite,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () {
        signInUser();
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
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
                  children: <Widget>[
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    buildEmailInput(),
                    SizedBox(
                      height: 15.0,
                    ),
                    buildPasswordInput(),
                    SizedBox(
                      height: 30.0,
                    ),
                    buildLoginBtn(),
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
