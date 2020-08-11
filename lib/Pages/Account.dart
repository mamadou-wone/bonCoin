import 'package:bonCoinSN/modals/user.dart';
import 'package:bonCoinSN/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () async {
                print(user.email);
                // print(user.email);
              },
              child: Text('Test'),
            ),
            Image.network(
              user.email,
              width: 150.0,
              height: 120.0,
            ),
            Text(
              user.name,
              style: TextStyle(fontSize: 30.0),
            ),
            FlatButton(
              onPressed: () async {
                await _auth.signOut();
                // print(user.email);
              },
              child: Text('SeDéconnecter'),
            ),
          ],
        ),
      ),
    );
  }
}
