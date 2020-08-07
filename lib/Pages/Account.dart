import 'package:bonCoinSN/services/auth.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'COMPTE',
              style: TextStyle(fontSize: 30.0),
            ),
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
