import 'package:bonCoinSN/modals/user.dart';
import 'package:bonCoinSN/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final AuthService _auth = AuthService();
  void _onLoading() async {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: new Duration(seconds: 4),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text("  Déconnection..."),
        ],
      ),
    ));
  }

  Future _signInout() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      key: _scaffoldKey,
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
                _onLoading();
                _signInout();
              },
              child: Text('SeDéconnecter'),
            ),
          ],
        ),
      ),
    );
  }
}
