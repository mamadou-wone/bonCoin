import 'package:bonCoinSN/home.dart';
import 'package:bonCoinSN/modals/user.dart';
import 'package:bonCoinSN/src/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return WelcomePage();
    } else {
      return Home();
    }
  }
}
