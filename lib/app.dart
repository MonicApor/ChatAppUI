import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/login.dart';
import './screens/signup.dart';
import './screens/welcome.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF01afbd),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
      },
    );
  }
}
