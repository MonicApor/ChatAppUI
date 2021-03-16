import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_app/modules/authentication.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {'email': '', 'password': ''};

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      await Provider.of<Authentication>(context, listen: false)
          .logIn(_authData['email'], _authData['password']);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
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
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value.isEmpty || !value.contains('@')) {
                return 'invalid email';
              }
              return null;
            },
            onSaved: (value) {
              _authData['email'] = value;
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
            obscureText: true,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value.isEmpty || value.length <= 5) {
                return 'invalid password';
              }
              return null;
            },
            onSaved: (value) {
              _authData['password'] = value;
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          _submit();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF009688),
            letterSpacing: 2.0,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
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
                      height: 35.0,
                    ),
                    buildEmailInput(),
                    SizedBox(
                      height: 15.0,
                    ),
                    buildPasswordInput(),
                    SizedBox(
                      height: 15.0,
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
