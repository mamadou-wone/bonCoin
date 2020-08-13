import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          Icon(Icons.settings),
        ],
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
        title: Text(
          'bonCoin',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
