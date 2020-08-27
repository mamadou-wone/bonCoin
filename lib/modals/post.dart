import 'dart:io';
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
      this.rating});

  List<Post> postData = <Post>[];
  final Firestore firestoreInstance = Firestore();
  void getData() async {
    firestoreInstance.collection("post").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        postData.add(
          Post(
              title: result['title'],
              description: result['description'],
              category: result['category'],
              location: result['location'],
              rating: result['rating'],
              firstImage: result['firstImage'],
              secondImage: result['secondImage'],
              thirdImage: result['thirdImage']),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Container();
  }
}
