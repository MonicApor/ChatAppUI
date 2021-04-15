//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/login.dart';
import 'package:flutter_chat_app/modules/auth_service.dart';
//import 'package:flutter_chat_app/modules/auth_service.dart';

// import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final _key = GlobalKey<FormState>();

  final AuthenticationService _auth = AuthenticationService();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

<<<<<<< HEAD:lib/screens/register.dart
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      await Provider.of<Authentication>(context, listen: false)
          .signUp(_authData['name'], _authData['email'], _authData['password']);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
=======
  void createUser() async {
    dynamic result = await _auth.createNewUser(
        _nameController.text, _emailController.text, _passwordController.text);
    if (result == null) {
      print('Email is not valid');
    } else {
      print(result.toString());
      _nameController.clear();
      _passwordController.clear();
      _emailController.clear();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
>>>>>>> f17a5c5... Sign In,Sign Up, & SignOut:lib/screens/signup.dart
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
            controller: _emailController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Name cannot be empty';
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

  buildNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Full Name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Name cannot be empty';
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
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter your name',
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
            obscureText: true,
            // onChanged: (value) {
            //   setState(() {
            //     _password = value.trim();
            //   });
            // },
            controller: _passwordController,
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

<<<<<<< HEAD:lib/screens/register.dart
  buildConfirmPassInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextFormField(
            obscureText: true,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value.isEmpty || value != _passwordController.text) {
                return 'Invalid Password';
              }
              return null;
            },
            onSaved: (value) {},
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.white, width: 1.0)),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.verified_user,
                color: Colors.white,
              ),
              hintText: 'Confirm your password',
              hintStyle: TextStyle(color: Colors.grey.shade100),
            ),
          ),
        ),
      ],
    );
  }

=======
>>>>>>> f17a5c5... Sign In,Sign Up, & SignOut:lib/screens/signup.dart
  buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'SIGN UP',
          style: TextStyle(
            color: Color(0xFF009688),
            letterSpacing: 2.0,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        // onPressed: () {
        //   auth
        //       .createUserWithEmailAndPassword(
        //           email: _email, password: _password)
        //       .then((_) {
        //     Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(builder: (context) => LoginScreen()));
        //   });
        // },
        onPressed: () {
          _auth.createNewUser(_nameController.text, _emailController.text,
              _passwordController.text);
          if (_auth.createNewUser(_nameController.text, _emailController.text,
                  _passwordController.text) ==
              null) {
            print('Email is not valid');
          } else {
            // print(result.toString());
            _nameController.clear();
            _passwordController.clear();
            _emailController.clear();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        },
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
          key: _key,
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
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    buildNameInput(),
                    SizedBox(
                      height: 15.0,
                    ),
                    buildEmailInput(),
                    SizedBox(
                      height: 15.0,
                    ),
                    buildPasswordInput(),
                    SizedBox(
                      height: 15.0,
                    ),
                    buildRegisterBtn(),
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

class FirestoreAuth {
  static var instance;
}
