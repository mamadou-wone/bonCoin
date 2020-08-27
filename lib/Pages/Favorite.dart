import 'package:bonCoin/Posts/post/model/post_list_data.dart';
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
  List<String> test = [];

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
        child: FlatButton(
          onPressed: () {
            print('tap');
          },
          child: Text('tap'),
        ),
      ),
    );
  }
}
