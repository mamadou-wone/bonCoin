import 'package:bonCoin/Pages/HomeScreen.dart';
import 'package:bonCoin/Posts/NewPost.dart';
import 'package:bonCoin/Posts/post/model/post_list_data.dart';
import 'package:bonCoin/home.dart';
import 'package:bonCoin/modals/user.dart';
import 'package:bonCoin/services/auth.dart';
import 'package:bonCoin/src/Widget/wrapper.dart';
import 'package:bonCoin/src/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  PostListData().dataResult();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
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
                        backgroundColor: Colors.indigo[900],
                        // gradientBackground: LinearGradient(
                        //     begin: Alignment.topCenter,
                        //     end: Alignment.bottomCenter,
                        //     colors: [Color(0xfffbb448), Color(0xffe46b10)]),
                        // backgroundColor: Color(0xfffbb448),
                        styleTextUnderTheLoader: new TextStyle(),
                        loaderColor: Colors.white),
                    type: PageTransitionType.rightToLeft);
                break;
              case "/home":
                return PageTransition(
                    child: Home(), type: PageTransitionType.fade);
                break;
              case "/post":
                return PageTransition(
                    child: NewPost(), type: PageTransitionType.downToUp);
                break;
              default:
                return null;
            }
          }),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
