import 'package:bonCoin/Pages/DetailPage.dart';
import 'package:bonCoin/modals/post.dart';
import 'package:bonCoin/modals/user.dart';
import 'package:bonCoin/services/auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TODO :Put the rating below the image post
  // SUNDAY 06/09/2020

  AuthService _auth = AuthService();
  double _screenWidth;
  double _screenHeight;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    final user = Provider.of<User>(context);
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('post')
            .orderBy('timeKey', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot post = snapshot.data.documents[index];
              return Post(
                title: post['title'],
                firstImage: post['firstImage'],
                category: post['category'],
                // secondImage: post['secondImage'],
                rating: double.parse(post['rating']),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        final List<String> images = [
                          post['firstImage'],
                          post['secondImage'],
                          post['thirdImage']
                        ];
                        final GlobalKey _cKey = GlobalKey();
                        return Scaffold(
                          backgroundColor: Colors.white,
                          body: Hero(
                            tag: post['title'],
                            child: CustomScrollView(
                              slivers: <Widget>[
                                SliverAppBar(
                                  elevation: 0.0,
                                  centerTitle: true,
                                  backgroundColor: Colors.indigo[900],
                                  title: Text(
                                    'bonCoin',
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SliverAppBar(
                                  automaticallyImplyLeading: false,
                                  elevation: 10.0,
                                  backgroundColor: Colors.grey[100],
                                  expandedHeight: 200,
                                  flexibleSpace: FlexibleSpaceBar(
                                    background: Container(
                                      // tag: post['firstImage'],
                                      child: GFCarousel(
                                        autoPlay: true,
                                        autoPlayCurve: Curves.linearToEaseOut,
                                        aspectRatio: 16 / 9,
                                        items: images.map(
                                          (url) {
                                            return Container(
                                              margin: EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                child: GestureDetector(
                                                  child: CachedNetworkImage(
                                                    imageUrl: url,
                                                    fit: BoxFit.cover,
                                                    width: 1000.0,
                                                    height: 3000.0,
                                                  ),
                                                  onTap: () {
                                                    Alert(
                                                      context: context,
                                                      style: AlertStyle(
                                                        isCloseButton: true,
                                                      ),
                                                      title: post['title'],
                                                      content: Container(
                                                        margin:
                                                            EdgeInsets.all(8.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                25.0),
                                                          ),
                                                          child: CarouselSlider
                                                              .builder(
                                                            itemCount:
                                                                images.length,
                                                            options:
                                                                CarouselOptions(
                                                              autoPlay: true,
                                                              enlargeCenterPage:
                                                                  true,
                                                              aspectRatio:
                                                                  16 / 9,
                                                              height: 300,
                                                            ),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return CachedNetworkImage(
                                                                imageUrl:
                                                                    images[
                                                                        index],
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: 1100.0,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ).show();
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                SliverAppBar(
                                  automaticallyImplyLeading: false,
                                  elevation: 10.0,
                                  backgroundColor: Colors.white,
                                  expandedHeight: 200,
                                  flexibleSpace: FlexibleSpaceBar(
                                    background: Column(
                                      children: [],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
