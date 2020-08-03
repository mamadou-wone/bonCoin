import 'package:bonCoinSN/Posts/NewPost.dart';
import 'package:bonCoinSN/home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/":
              return PageTransition(
                  child: new SplashScreen(
                      seconds: 5,
                      navigateAfterSeconds: new Home(),
                      title: new Text(
                        'BON COIN',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      backgroundColor: Colors.blueGrey[400],
                      styleTextUnderTheLoader: new TextStyle(),
                      loaderColor: Colors.white),
                  type: PageTransitionType.rightToLeft);
              break;
            case "/post":
              return PageTransition(
                  child: NewPost(), type: PageTransitionType.downToUp);
            default:
              return null;
          }
        });
  }
}
