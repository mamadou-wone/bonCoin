import 'package:bonCoin/Pages/DetailPage.dart';
import 'package:bonCoin/modals/user.dart';
import 'package:bonCoin/services/auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('post').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot post = snapshot.data.documents[index];
              return DetailPage(
                photo: post['firstIage'],
                width: 50.0,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return Scaffold(
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        elevation: 0.0,
                        centerTitle: true,
                        backgroundColor: Colors.indigo[900],
                        title: Text(
                          'bonCoin',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      body: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              CachedNetworkImage(imageUrl: post['firstIage']),
                            ],
                          )),
                    );
                  }));
                },
              );
            },
          );
        },
      ),
    );
  }
}
