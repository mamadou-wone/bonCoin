import 'package:bonCoin/Pages/CientTest.dart';
import 'package:bonCoin/Pages/TestDATA.dart';
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

// 07/10/2020
// 08/10/2020
class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final Firestore firestoreInstance = Firestore();
  List<Post> post = <Post>[];
  // final fido = Dog(
  //   id: 0,
  //   name: 'Gros CHien',
  //   age: 35,
  // );

  Client client = Client(firstName: 'Boss', lastName: 'Boss2', blocked: false);

  @override
  Widget build(BuildContext context) {
    // testData();
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('tap'),
          onPressed: () async {
            await DBProvider.db.newClient(client);
            // print(await DBProvider.db.getAllClient());
          },
        ),
      ),
    );
  }
}
