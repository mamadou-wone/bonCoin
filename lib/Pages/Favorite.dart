import 'package:bonCoin/Posts/post/model/post_list_data.dart';
import 'package:bonCoin/iPhoneXXS11Pro1.dart';
import 'package:bonCoin/modals/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final Firestore firestoreInstance = Firestore();
  List<Post> post = <Post>[];
  List<String> test = [];

  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg"
  ];

  void testData() {
    firestoreInstance.collection("post").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        // test.add('test');
        // post.add(
        //   Post(
        //       title: result['title'],
        //       description: result['description'],
        //       category: result['category'],
        //       location: result['location'],
        //       rating: double.parse(result['rating']),
        //       firstImage: result['firstImage'],
        //       secondImage: result['secondImage'],
        //       thirdImage: result['thirdImage']),
        // );
      });
    });
    print(post);
  }

  @override
  Widget build(BuildContext context) {
    // testData();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LineIcons.smile_o,
              color: Colors.grey.withOpacity(0.8),
              size: 100.0,
            ),
            Text(
              'Aucun Favorie',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.grey.withOpacity(0.8)),
            ),
          ],
        ),
      ),
    );
  }
}
