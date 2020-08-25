import 'dart:io';

import 'package:bonCoin/modals/user.dart';
import 'package:bonCoin/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final picker = ImagePicker();
  final picker2 = ImagePicker();
  final picker3 = ImagePicker();
  Timestamp timestamp = Timestamp.now();
  String url;
  @override
  Widget build(BuildContext context) {
    var imageTest;
    final user = Provider.of<User>(context);
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

                    onSaved: (val) {
                      // print('test');
                      if (_image != null) {
                        print('Image picker ' + _image.toString());
                      }
                      setState(() {
                        imageTest = val;
                        // saveDataInFirestore(imageTest[0]);
                        DataBase().addNewUserPost(
                            uid: user.uid,
                            category: 'Plage1234',
                            description: 'Test sur la plage',
                            firstImage: imageTest[0],
                            location: 'Rufisque',
                            secondImage: imageTest[1],
                            thirdImage: imageTest.length < 3
                                ? imageTest[1]
                                : imageTest[2],
                            timekey: new DateTime.now().toString(),
                            title: 'Les Vacances');
                        // print('Image Picker ' + imageTest[0].toString());
                      });
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
                      // if (_image != null) {
                      //   print(_image);
                      // }
                      if (_fbKey.currentState.saveAndValidate()) {
                        // print(_fbKey.currentState.value);
                        // print(imageTest);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
