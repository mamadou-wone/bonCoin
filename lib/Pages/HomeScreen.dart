import 'package:bonCoin/Pages/DetailPage.dart';
import 'package:bonCoin/modals/user.dart';
import 'package:bonCoin/services/auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
                photo: post['firstImage'],
                width: 50.0,
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
                              background: Hero(
                                tag: post['firstImage'],
                                child: CarouselSlider.builder(
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
