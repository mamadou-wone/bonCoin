import 'dart:io';

import 'package:bonCoin/modals/user.dart';
import 'package:bonCoin/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final ValueChanged _onChanged = (val) => print(val);
  var genderOptions = ['Male', 'Female', 'Other'];
  final _ageController = TextEditingController(text: '45');
  bool _ageHasError = false;

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
    dynamic saveDataInFirestore(image) async {
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child("Post Images");

      var timeKey = new DateTime.now();
      var testImage;
      final StorageUploadTask uploadTask =
          postImageRef.child(timeKey.toString() + ' .jpg').putFile(image);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();
      print(url);
      // var dbTimeKey = new DateTime.now();
      // var formatDate = new DateFormat('MMM d,yyyy');
      // var formatTime = new DateFormat('EEEE,hh:mm aaa');

      // String date = formatDate.format(dbTimeKey);
      // String time = formatTime.format(dbTimeKey);
      // // DatabaseReference rf = FirebaseDatabase.instance.reference();
      // final CollectionReference postCollection =
      //     Firestore.instance.collection('post' + user.email);
      // postCollection.document(user.uid).parent().add({
      //   'image': url,
      //   'description': 'Test upload image',
      //   'date': date,
      //   'time': time
      // });

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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            FormBuilder(
              // context,
              key: _fbKey,
              // autovalidate: true,
              initialValue: {
                'movie_rating': 3,
                'filter_chip': ['Test', 'Test 1'],
                'date': DateTime.now(),
              },
              readOnly: false,
              child: Column(
                children: <Widget>[
                  // FormBuilderDateTimePicker(
                  //   attribute: 'date',
                  //   onChanged: _onChanged,
                  //   inputType: InputType.both,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Appointment Time',
                  //   ),
                  //   validator: (val) => null,
                  //   initialTime: TimeOfDay(hour: 8, minute: 0),
                  //   // initialValue: DateTime.now(),
                  //   // readonly: true,
                  // ),
                  // SizedBox(height: 15),
                  // FormBuilderDateRangePicker(
                  //   attribute: 'date_range',
                  //   firstDate: DateTime(1970),
                  //   lastDate: DateTime.now(),
                  //   initialValue: [
                  //     DateTime.now().subtract(Duration(days: 30)),
                  //     DateTime.now().subtract(Duration(seconds: 10))
                  //   ],
                  //   format: DateFormat('yyyy-MM-dd'),
                  //   onChanged: _onChanged,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Date Range',
                  //     helperText: 'Helper text',
                  //     hintText: 'Hint text',
                  //   ),
                  // ),
                  FormBuilderDropdown(
                    attribute: 'gender',
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                    ),
                    // initialValue: 'Male',
                    hint: Text('Select Gender'),
                    validators: [FormBuilderValidators.required()],
                    items: genderOptions
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text('$gender'),
                            ))
                        .toList(),
                    // isExpanded: false,
                    allowClear: true,
                  ),
                  SizedBox(height: 15),
                  FormBuilderRadioGroup(
                    decoration:
                        InputDecoration(labelText: 'My chosen language'),
                    attribute: 'best_language',
                    onChanged: _onChanged,
                    validators: [FormBuilderValidators.required()],
                    options: ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text('$lang'),
                            ))
                        .toList(growable: false),
                  ),
                  SizedBox(height: 15),
                  FormBuilderRate(
                    decoration:
                        const InputDecoration(labelText: 'Rate this form'),
                    attribute: 'rate',
                    iconSize: 32.0,
                    initialValue: 1.0,
                    max: 5.0,
                    onChanged: _onChanged,
                    // readOnly: true,
                    filledColor: Colors.red,
                    emptyColor: Colors.pink[100],
                    isHalfAllowed: true,
                  ),
                  SizedBox(height: 15),
                  FormBuilderImagePicker(
                    attribute: 'images',
                    decoration: const InputDecoration(
                      labelText: 'Images',
                    ),
                    defaultImage: NetworkImage(
                        'https://cohenwoodworking.com/wp-content/uploads/2016/09/image-placeholder-500x500.jpg'),
                    maxImages: 3,
                    iconColor: Colors.red,
                    // readOnly: true,
                    // validators: [
                    //   FormBuilderValidators.required(),
                    //   (images) {
                    //     if (images.length < 2) {
                    //       return 'Two or more images required.';
                    //     }
                    //     return null;
                    //   }
                    // ],
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 15),
                  FormBuilderPhoneField(
                    attribute: 'phone_number',
                    // defaultSelectedCountryIsoCode: 'KE',
                    cursorColor: Colors.black,
                    // style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                    onChanged: _onChanged,
                    priorityListByIsoCode: ['US'],
                    validators: [
                      FormBuilderValidators.numeric(
                          errorText: 'Invalid phone number'),
                      FormBuilderValidators.required(
                          errorText: 'This field reqired')
                    ],
                  ),
                  SizedBox(height: 15),
                  FormBuilderRadioGroup(
                    attribute: 'radio_group',
                    decoration: const InputDecoration(labelText: 'Radio Group'),
                    onChanged: _onChanged,
                    options: [
                      FormBuilderFieldOption(value: 'M', child: Text('Male')),
                      FormBuilderFieldOption(value: 'F', child: Text('Female')),
                    ],
                  ),
                  SizedBox(height: 15),
                  FormBuilderCustomField(
                    attribute: 'name',
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    initialValue: 'Argentina',
                    formField: FormField(
                      enabled: true,
                      builder: (FormFieldState<dynamic> field) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'FormBuilderCustomField',
                            contentPadding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 0.0,
                            ),
                            border: InputBorder.none,
                            errorText: field.errorText,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        // print(_fbKey.currentState.value);
                        if (_image != null) {
                          saveDataInFirestore(_image);
                        }
                      } else {
                        print(_fbKey.currentState.value);
                        print('validation failed');
                      }
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _fbKey.currentState.reset();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     // ListTile(
      //     //   title: Text('Horse'),
      //     //   subtitle: Text('A strong animal'),
      //     // ),
      //     Container(
      //       padding: EdgeInsets.only(top: 8.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           GestureDetector(
      //             child: _image == null
      //                 ? Container(
      //                     height: 100.0,
      //                     width: 100.0,
      //                     color: Colors.grey,
      //                     child: Icon(
      //                       Icons.add_a_photo,
      //                       size: 70.0,
      //                       color: Colors.blueGrey[700],
      //                     ),
      //                   )
      //                 : Container(
      //                     child: Image.file(_image),
      //                     height: 100.0,
      //                     width: 100.0,
      //                   ),
      //             onTap: getImage,
      //           ),
      //           GestureDetector(
      //             child: _image2 == null
      //                 ? Container(
      //                     height: 100.0,
      //                     width: 100.0,
      //                     color: Colors.grey,
      //                     child: Icon(
      //                       Icons.add_a_photo,
      //                       size: 70.0,
      //                       color: Colors.blueGrey[700],
      //                     ),
      //                   )
      //                 : Container(
      //                     child: Image.file(_image2),
      //                     height: 100.0,
      //                     width: 100.0,
      //                   ),
      //             onTap: () {
      //               var timekey = new DateTime.now();
      //               DataBase().addNewUserPost(
      //                   user.uid,
      //                   timekey.toString(),
      //                   'Plage',
      //                   'Meilleur Plage du monde',
      //                   'Saly',
      //                   'Loisir',
      //                   'firstImage',
      //                   'secondImage',
      //                   'thirdImage');

      //               DataBase().addNewPost(
      //                   user.uid,
      //                   timekey.toString(),
      //                   'Plage',
      //                   'Meilleur Plage du monde',
      //                   'Saly',
      //                   'Loisir',
      //                   'firstImage',
      //                   'secondImage',
      //                   'thirdImage');
      //             },
      //           ),
      //           GestureDetector(
      //             child: _image3 == null
      //                 ? Container(
      //                     height: 100.0,
      //                     width: 100.0,
      //                     color: Colors.grey,
      //                     child: Icon(
      //                       Icons.add_a_photo,
      //                       size: 70.0,
      //                       color: Colors.blueGrey[700],
      //                     ),
      //                   )
      //                 : Container(
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(12.0),
      //                       // color: Colors.white,
      //                     ),
      //                     child: Image.file(
      //                       _image3,
      //                       width: 100.0,
      //                       height: 100.0,
      //                     ),
      //                   ),
      //             onTap: () async {
      //               firestoreInstance
      //                   .collection("test")
      //                   .getDocuments()
      //                   .then((querySnapshot) {
      //                 querySnapshot.documents.forEach((result) {
      //                   firestoreInstance
      //                       .collection('test')
      //                       .document(user.uid)
      //                       .collection('users')
      //                       .getDocuments()
      //                       .then((querySnapshot) {
      //                     querySnapshot.documents.forEach((element) {
      //                       print(element.data);
      //                     });
      //                   });
      //                 });
      //               });
      //             },
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
