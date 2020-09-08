import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:bonCoin/Posts/post/post_app_theme.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Post extends StatefulWidget {
  final String uid;
  final String timekey;
  final String title;
  final String description;
  final String location;
  final String category;
  final String firstImage;
  final String secondImage;
  final String thirdImage;
  final String phoneNumber;
  final bool isFavorite;
  final double rating;
  final VoidCallback onTap;
// TODO : Sunday the day for relax
  Post(
      {this.uid,
      this.timekey,
      this.title,
      this.description,
      this.location,
      this.category,
      this.firstImage,
      this.secondImage,
      this.thirdImage,
      this.phoneNumber,
      this.isFavorite,
      this.rating,
      this.onTap});

  @override
  _PostState createState() => _PostState();
}

getIcon(String category) {
  switch (category) {
    case 'Restaurant':
      return Icon(LineIcons.code, color: Colors.grey.withOpacity(0.8));
      break;
    case 'Technologie':
      return Icon(Icons.bluetooth_connected,
          color: Colors.grey.withOpacity(0.8));
      break;
    case 'Plage':
      return Icon(Icons.bluetooth_connected,
          color: Colors.grey.withOpacity(0.8));
      break;
    case 'Piscine':
      return Icon(Icons.bluetooth_connected,
          color: Colors.grey.withOpacity(0.8));
      break;
    case 'Parc Culturel':
      return Icon(Icons.bluetooth_connected,
          color: Colors.grey.withOpacity(0.8));
      break;
    default:
      return Icon(Icons.ac_unit, color: Colors.grey.withOpacity(0.8));
  }
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    // getSearchBarUI();
    // TODO: Make a beautifull ui
    return SizedBox(
      child: Hero(
        tag: this.widget.firstImage,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            child: GFCard(
              boxFit: BoxFit.cover,
              title: GFListTile(
                subTitle: Row(
                  children: [
                    Text(
                      widget.category,
                      style: TextStyle(
                          fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    getIcon(widget.category),
                  ],
                ),
                title: Text(
                  widget.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
              elevation: 1.0,
              content: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 0.7,
                      child: CachedNetworkImage(
                        imageUrl: widget.firstImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(LineIcons.heart_o,
                                color: PostAppTheme.buildLightTheme()
                                    .primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buttonBar: GFButtonBar(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: <Widget>[
                        SmoothStarRating(
                          allowHalfRating: true,
                          starCount: 5,
                          rating: widget.rating,
                          size: 20,
                          color: PostAppTheme.buildLightTheme().primaryColor,
                          borderColor:
                              PostAppTheme.buildLightTheme().primaryColor,
                        ),
                        Text(
                          ' Note',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
