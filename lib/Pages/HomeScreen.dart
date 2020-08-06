import 'package:bonCoinSN/services/auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                _auth.signOut();
              },
              child: Text('SeDéconnecter'),
            ),
          ],
        ),
      ),
    );
  }
}
