import 'package:bonCoinSN/Pages/HomeScreen.dart';
import 'package:bonCoinSN/Posts/NewPost.dart';
import 'package:bonCoinSN/home.dart';
import 'package:bonCoinSN/modals/user.dart';
import 'package:bonCoinSN/services/auth.dart';
import 'package:bonCoinSN/src/Widget/wrapper.dart';
import 'package:bonCoinSN/src/loginPage.dart';
import 'package:bonCoinSN/src/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
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
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case "/":
                return PageTransition(
                    child: new SplashScreen(
                        seconds: 5,
                        navigateAfterSeconds: new Wrapper(),
                        title: new Text(
                          'bonCoin',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        gradientBackground: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xfffbb448), Color(0xffe46b10)]),
                        // backgroundColor: Color(0xfffbb448),
                        styleTextUnderTheLoader: new TextStyle(),
                        loaderColor: Colors.white),
                    type: PageTransitionType.rightToLeft);
                break;
              case "/home":
                return PageTransition(
                    child: Home(), type: PageTransitionType.fade);
              case "/login":
                return PageTransition(
                    child: LoginPage(), type: PageTransitionType.fade);
              case "/post":
                return PageTransition(
                    child: NewPost(), type: PageTransitionType.downToUp);
              default:
                return null;
            }
          }),
    );
  }
}
