import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './modules/authentication.dart';
import './screens/home_screen.dart';
import './screens/login.dart';
import './screens/register.dart';
import './screens/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Authentication(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Color(0xFF01afbd),
          ),
          // home: HomeScreen(),
          initialRoute: '/',
          routes: {
            '/': (context) => WelcomeScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            RegisterScreen.routeName: (ctx) => RegisterScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
          },
        ));
  }
}
