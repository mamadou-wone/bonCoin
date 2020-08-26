import 'package:bonCoin/modals/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final Firestore firestoreInstance = Firestore();
  List<Post> post = <Post>[];

  @override
  Widget build(BuildContext context) {
    firestoreInstance.collection("post").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        post.add(Post(
            title: result['title'],
            description: result['description'],
            category: result['category'],
            location: result['location'],
            rating: result['rating'],
            firstImage: result['firstImage'],
            secondImage: result['secondImage'],
            thirdImage: result['thirdImage']));
      });
    });
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: () {
            print(post);
          },
          child: Text('tap'),
        ),
      ),
    );
  }
}
