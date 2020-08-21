import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  var timeKey = new DateTime.now();
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
                  onTap: getImage2,
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
                  onTap: getImage3,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            timeKey = new DateTime.now();
            print(timeKey.toString());
          });
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
