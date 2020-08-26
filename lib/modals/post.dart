import 'dart:io';
import 'package:flutter/cupertino.dart';

class Post {
  final String uid;
  final String timekey;
  final String title;
  final String description;
  final String location;
  final String category;
  final File firstImage;
  final File secondImage;
  final File thirdImage;
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
}
