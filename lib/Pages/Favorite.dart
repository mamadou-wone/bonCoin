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
      appBar: AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: 'assets/images/placeholder.jpg',
          width: 300.0,
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute<void>(builder: (BuildContext context) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: const Text('Flippers Page'),
                ),
                body: Container(
                  // The blue background emphasizes that it's a new route.
                  color: Colors.lightBlueAccent,
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.topLeft,
                  child: PhotoHero(
                    photo: 'assets/images/placeholder.jpg',
                    width: 100.0,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({Key key, this.photo, this.onTap, this.width})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
