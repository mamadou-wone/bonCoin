import 'package:bonCoin/Pages/DetailPage.dart';
import 'package:bonCoin/home.dart';
import 'package:bonCoin/modals/user.dart';
import 'package:bonCoin/services/auth.dart';
import 'package:bonCoin/services/database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
        title: Text(
          'bonCoin',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('post')
            .where('uid', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot post = snapshot.data.documents[index];
              return DetailPage(
                photo: post['firstImage'],
                rating: double.parse(post['rating']),
                title: post['title'],
                category: post['category'],
                description: post['description'],
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    final List<String> images = [
                      post['firstImage'],
                      post['secondImage'],
                      post['thirdImage']
                    ];
                    return Scaffold(
                      backgroundColor: Colors.white,
                      body: CustomScrollView(
                        slivers: <Widget>[
                          SliverAppBar(
                            elevation: 10.0,
                            backgroundColor: Colors.grey[100],
                            expandedHeight: 300,
                            flexibleSpace: FlexibleSpaceBar(
                              background: CarouselSlider.builder(
                                itemCount: images.length,
                                options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 16 / 9,
                                  height: 300,
                                ),
                                itemBuilder: (context, index) {
                                  return CachedNetworkImage(
                                    imageUrl: images[index],
                                    fit: BoxFit.cover,
                                    width: 1100.0,
                                  );
                                },
                              ),
                            ),
                          ),
                          SliverAppBar(
                            elevation: 10.0,
                            backgroundColor: Colors.grey[100],
                            expandedHeight: 300,
                            flexibleSpace: FlexibleSpaceBar(
                              background: FlatButton(
                                child: Text('delete'),
                                onPressed: () async {
                                  var firebaseUser =
                                      await FirebaseAuth.instance.currentUser();
                                  DataBase()
                                      .deletePost(firebaseUser.uid)
                                      .whenComplete(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()));
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
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
