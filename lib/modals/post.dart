import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
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

  // List<Post> postData = <Post>[];
  // final Firestore firestoreInstance = Firestore();

  @override
  Widget build(BuildContext context) {
    // TODO: Make a beautifull ui
    return SizedBox(
      child: Hero(
        tag: this.firstImage,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: CachedNetworkImage(
              imageUrl: this.firstImage,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
