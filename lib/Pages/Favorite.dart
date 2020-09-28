import 'package:bonCoin/Pages/test.dart';
import 'package:bonCoin/Pages/testDB.dart';
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
  // final fido = Dog(
  //   id: 0,
  //   name: 'Gros CHien',
  //   age: 35,
  // );

  @override
  Widget build(BuildContext context) {
    // testData();
    return Scaffold(
      body: TestDog(),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Icon(
      //         LineIcons.smile_o,
      //         color: Colors.grey.withOpacity(0.8),
      //         size: 100.0,
      //       ),
      //       Text(
      //         'Aucun Favorie',
      //         style: TextStyle(
      //             fontWeight: FontWeight.w600,
      //             fontSize: 22,
      //             color: Colors.grey.withOpacity(0.8)),
      //       ),
      //       FlatButton(
      //         child: Text('tap'),
      //         onPressed: () async {
      //           // print(await Favories().dogs());
      //         },
      //         onLongPress: () async {
      //           // print(await Favories().dogs());
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
