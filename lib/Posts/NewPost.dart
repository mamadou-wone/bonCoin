import 'dart:io';

import 'package:bonCoin/modals/user.dart';
import 'package:bonCoin/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File _image;
  File _image2;
  File _image3;
  final picker = ImagePicker();
  final picker2 = ImagePicker();
  final picker3 = ImagePicker();
  Timestamp timestamp = Timestamp.now();
  String url;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImage2() async {
    final pickedFile = await picker2.getImage(source: ImageSource.gallery);

    setState(() {
      _image2 = File(pickedFile.path);
    });
  }

  Future getImage3() async {
    final pickedFile = await picker3.getImage(source: ImageSource.gallery);

    setState(() {
      _image3 = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final firestoreInstance = Firestore.instance;
    void saveDataInFirestore() async {
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child("Post Images");

      var timeKey = new DateTime.now();

      final StorageUploadTask uploadTask =
          postImageRef.child(timeKey.toString() + ' .jpg').putFile(_image);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();

      var dbTimeKey = new DateTime.now();
      var formatDate = new DateFormat('MMM d,yyyy');
      var formatTime = new DateFormat('EEEE,hh:mm aaa');

      String date = formatDate.format(dbTimeKey);
      String time = formatTime.format(dbTimeKey);
      // DatabaseReference rf = FirebaseDatabase.instance.reference();
      final CollectionReference postCollection =
          Firestore.instance.collection('post' + user.email);
      postCollection.document(user.uid).parent().add({
        'image': url,
        'description': 'Test upload image',
        'date': date,
        'time': time
      });

      // var data = {
      //   'image': url,
      //   'description': 'Test upload image',
      //   'date': date,
      //   'time': time
      // };

      // rf.child('Posts').push().set(data);
      // saveToDataBase(url);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
        title: Text(
          'bonCoin',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // ListTile(
          //   title: Text('Horse'),
          //   subtitle: Text('A strong animal'),
          // ),
          Container(
            padding: EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: _image == null
                      ? Container(
                          height: 100.0,
                          width: 100.0,
                          color: Colors.grey,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 70.0,
                            color: Colors.blueGrey[700],
                          ),
                        )
                      : Container(
                          child: Image.file(_image),
                          height: 100.0,
                          width: 100.0,
                        ),
                  onTap: getImage,
                ),
                GestureDetector(
                  child: _image2 == null
                      ? Container(
                          height: 100.0,
                          width: 100.0,
                          color: Colors.grey,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 70.0,
                            color: Colors.blueGrey[700],
                          ),
                        )
                      : Container(
                          child: Image.file(_image2),
                          height: 100.0,
                          width: 100.0,
                        ),
                  onTap: () {
                    var timekey = new DateTime.now();
                    DataBase().addNewUserPost(
                        user.uid,
                        timekey.toString(),
                        'Plage',
                        'Meilleur Plage du monde',
                        'Saly',
                        'Loisir',
                        'firstImage',
                        'secondImage',
                        'thirdImage');

                    DataBase().addNewPost(
                        user.uid,
                        timekey.toString(),
                        'Plage',
                        'Meilleur Plage du monde',
                        'Saly',
                        'Loisir',
                        'firstImage',
                        'secondImage',
                        'thirdImage');
                  },
                ),
                GestureDetector(
                  child: _image3 == null
                      ? Container(
                          height: 100.0,
                          width: 100.0,
                          color: Colors.grey,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 70.0,
                            color: Colors.blueGrey[700],
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            // color: Colors.white,
                          ),
                          child: Image.file(
                            _image3,
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                  onTap: () async {
                    firestoreInstance
                        .collection("test")
                        .getDocuments()
                        .then((querySnapshot) {
                      querySnapshot.documents.forEach((result) {
                        firestoreInstance
                            .collection('test')
                            .document(user.uid)
                            .collection('users')
                            .getDocuments()
                            .then((querySnapshot) {
                          querySnapshot.documents.forEach((element) {
                            print(element.data);
                          });
                        });
                      });
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _image == null ? null : saveDataInFirestore,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
