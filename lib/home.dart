import 'package:bonCoin/Pages/Account.dart';
import 'package:bonCoin/Pages/Favorite.dart';
import 'package:bonCoin/Pages/mapScreen.dart';
import 'package:bonCoin/Posts/NewPost.dart';
import 'package:bonCoin/settings/settingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'Pages/HomeScreen.dart';
import 'modals/user.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;
  Home({this.user});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomeScreen(),
        Favorite(),
        SettingScreen(),
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
        title: Text(
          'bonCoin',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: buildPageView()),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10).add(EdgeInsets.only(top: 5)),
            child: GNav(
                gap: 10,
                activeColor: Colors.white,
                color: Colors.grey[400],
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.grey[800],
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                    backgroundColor: Colors.indigo[900],
                  ),
                  GButton(
                    icon: LineIcons.heart_o,
                    text: 'Favorie',
                    backgroundColor: Colors.red,
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Compte',
                    backgroundColor: Color(0xfffbb448),
                  ),
                ],
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    pageController.jumpToPage(index);
                  });
                }),
          ),
        ),
      ),
      // Static Day
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        child: Icon(Icons.add),
        elevation: 10.0,
        splashColor: Colors.indigo[700],
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewPost(),
            ),
          );
        },
      ),
    );
  }
}
