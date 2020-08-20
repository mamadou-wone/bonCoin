import 'package:bonCoin/home.dart';
import 'package:bonCoin/modals/user.dart';
import 'package:bonCoin/src/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(('User not connect'));
    if (user == null) {
      return WelcomePage();
    } else {
      return Home();
      // Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}
