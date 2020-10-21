import 'dart:io';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:bonCoin/Pages/HomeScreen.dart';
import 'package:bonCoin/modals/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataBase {
  final CollectionReference postCollection =
      Firestore.instance.collection('post');

  final firestoreInstance = Firestore.instance;
  String url;
  String url2;
  String url3;

// 21/10/2020
  Future updateUserData(
      String uid,
      String timekey,
      String title,
      String description,
      String location,
      String category,
      File firstImage,
      File secondImage,
      File thirdImage) async {
    return await postCollection.document(uid).setData({
      'timeKey': timekey,
      'title': title,
      'description': description,
      'location': location,
      'category': category,
      'firstIage': url,
      'secondImage': secondImage ?? '',
      'thirdImage': thirdImage ?? ''
    });
  }

  Future addNewUserPost(
      {String uid,
      String timekey,
      String title,
      String rating,
      String description,
      String location,
      String category,
      String phone,
      File firstImage,
      File secondImage,
      File thirdImage}) async {
    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child("ImagePost1");

    final StorageReference postImageRef2 =
        FirebaseStorage.instance.ref().child("ImagePost2");

    final StorageReference postImageRef3 =
        FirebaseStorage.instance.ref().child("ImagePost3");

    var timeKey = new DateTime.now();
    final StorageUploadTask uploadTask =
        postImageRef.child(timeKey.toString() + ' .jpg').putFile(firstImage);
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = imageUrl.toString();

    final StorageUploadTask uploadTask2 =
        postImageRef2.child(timeKey.toString() + ' .jpg').putFile(secondImage);
    var imageUrl2 = await (await uploadTask2.onComplete).ref.getDownloadURL();
    url2 = imageUrl2.toString();

    final StorageUploadTask uploadTask3 =
        postImageRef3.child(timeKey.toString() + ' .jpg').putFile(thirdImage);
    var imageUrl3 = await (await uploadTask3.onComplete).ref.getDownloadURL();
    url3 = imageUrl3.toString();
    return await postCollection.document(uid).collection('userPosts').add({
      'timeKey': timekey,
      'title': title,
      'description': description,
      'location': location,
      'category': category,
      'rating': rating,
      'phone': phone,
      'firstImage': url,
      'secondImage': url2,
      'thirdImage': url3
    }).then((value) {
      print(value.documentID);
    });
  }

  Future addNewPost(
      {String uid,
      String timekey,
      String title,
      String rating,
      String description,
      String location,
      String category,
      String phone,
      File firstImage,
      File secondImage,
      File thirdImage}) async {
    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child("userImage");

    final StorageReference postImageRef2 =
        FirebaseStorage.instance.ref().child("userImage2");

    final StorageReference postImageRef3 =
        FirebaseStorage.instance.ref().child("userImage3");

    var timeKey = new DateTime.now();
    final StorageUploadTask uploadTask =
        postImageRef.child(timeKey.toString() + ' .jpg').putFile(firstImage);
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = imageUrl.toString();

    final StorageUploadTask uploadTask2 =
        postImageRef2.child(timeKey.toString() + ' .jpg').putFile(secondImage);
    var imageUrl2 = await (await uploadTask2.onComplete).ref.getDownloadURL();
    url2 = imageUrl2.toString();

    final StorageUploadTask uploadTask3 =
        postImageRef3.child(timeKey.toString() + ' .jpg').putFile(thirdImage);
    var imageUrl3 = await (await uploadTask3.onComplete).ref.getDownloadURL();
    url3 = imageUrl3.toString();
    return await postCollection.add({
      'uid': uid,
      'timeKey': timekey,
      'title': title,
      'description': description,
      'location': location,
      'rating': rating,
      'category': category,
      'phone': phone,
      'firstImage': url,
      'secondImage': url2,
      'thirdImage': url3
    }).whenComplete(() {});
  }

  Future deletePost(uid) async {
    // var firebaseUser = await FirebaseAuth.instance.currentUser();

    // var user = User();
    postCollection.document(uid).delete().then((value) => print('success'));
  }
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}

// SQFLITE
void getFavorie() async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'test'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE favorite(uid STRING PRIMARY KEY , title TEXT)',
      );
    },
    version: 1,
  );

  Future<void> insertDog(Dog dog) async {
    final Database db = await database;
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  final fido = Dog(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  await insertDog(fido);
}
