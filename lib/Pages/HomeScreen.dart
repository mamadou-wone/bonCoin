import 'package:bonCoinSN/modals/user.dart';
import 'package:bonCoinSN/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: Column(
        children: [
          // CircleAvatar(
          //   radius: 20.0,
          // ),
          Image.network(
            'https://png.pngtree.com/png-clipart/20190516/original/pngtree-whatsapp-icon-png-image_3584844.jpg',
            width: 50.0,
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
