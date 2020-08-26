import 'dart:io';

import 'package:bonCoin/modals/user.dart';
import 'package:bonCoin/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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

  var categorieOptions = [
    'Plage',
    'Restaurant',
    'Technologie',
    'Piscine',
    'Parc Cuturel',
  ];
  // final _ageController = TextEditingController(text: '45');
  // bool _ageHasError = false;

  // File _image;
  Timestamp timestamp = Timestamp.now();
  String url;
  @override
  Widget build(BuildContext context) {
    final Firestore firestoreInstance = Firestore();
    String title;
    String category;
    String description;
    String address;
    double rating;
    var phone;
    var postImage;
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
                  FormBuilderTextField(
                    attribute: "titre",
                    decoration:
                        InputDecoration(labelText: "Donnez le nom de ce lieu"),
                    validators: [
                      FormBuilderValidators.max(20),
                      FormBuilderValidators.required(
                          errorText: 'Ce champ est obligatoire'),
                    ],
                    onSaved: (val) {
                      setState(() {
                        title = val;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  FormBuilderDropdown(
                    attribute: 'categorie',
                    decoration: const InputDecoration(
                      labelText: 'Catégorie',
                    ),
                    // initialValue: 'Male',
                    hint: Text('Selectionner une Catégorie'),
                    validators: [FormBuilderValidators.required()],
                    items: categorieOptions
                        .map((categorie) => DropdownMenuItem(
                              value: categorie,
                              child: Text('$categorie'),
                            ))
                        .toList(),
                    // isExpanded: false,
                    allowClear: true,
                    onSaved: (val) {
                      setState(() {
                        category = val;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  FormBuilderTextField(
                    attribute: "titre",
                    decoration:
                        InputDecoration(labelText: "Donnez une Description"),
                    validators: [
                      FormBuilderValidators.max(200),
                      FormBuilderValidators.required(
                          errorText: 'Ce champ est obligatoire'),
                    ],
                    onSaved: (val) {
                      setState(() {
                        description = val;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  FormBuilderTextField(
                    attribute: "addresse",
                    decoration:
                        InputDecoration(labelText: "Donnez une Addresse"),
                    validators: [
                      FormBuilderValidators.max(200),
                      FormBuilderValidators.required(
                          errorText: 'Ce champ est obligatoire'),
                    ],
                    onSaved: (val) {
                      setState(() {
                        address = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  FormBuilderRate(
                    decoration:
                        const InputDecoration(labelText: 'Noter ce lieu'),
                    attribute: 'rate',
                    iconSize: 32.0,
                    initialValue: 1.0,
                    max: 5.0,
                    // onChanged: _onChanged,
                    onSaved: (val) {
                      setState(() {
                        rating = val;
                      });
                    },
                    // readOnly: true,
                    filledColor: Colors.red,
                    emptyColor: Colors.pink[100],
                    isHalfAllowed: true,
                    validators: [
                      FormBuilderValidators.required(
                          errorText: 'Veuillez donner une note'),
                    ],
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
                    validators: [
                      FormBuilderValidators.required(),
                      (images) {
                        if (images.length < 2) {
                          return 'Selectionner trois images !.';
                        }
                        return null;
                      }
                    ],
                    onSaved: (val) {
                      setState(() {
                        postImage = val;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  FormBuilderPhoneField(
                    defaultSelectedCountryIsoCode: 'SN',
                    attribute: 'phone_number',
                    // defaultSelectedCountryIsoCode: 'KE',
                    cursorColor: Colors.black,
                    // style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Téléphone',
                    ),
                    onSaved: (val) {
                      setState(() {
                        phone = val;
                      });
                    },
                    priorityListByIsoCode: ['SN'],
                    validators: [
                      FormBuilderValidators.numeric(
                          errorText: 'Numéro invalide'),
                      FormBuilderValidators.required(
                          errorText: 'Ce champ est obligatoire')
                    ],
                  ),
                  SizedBox(height: 15),
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
                    onPressed: () async {
                      if (_fbKey.currentState.saveAndValidate()) {
                        await DataBase().addNewUserPost(
                            uid: user.uid,
                            category: category,
                            description: description,
                            firstImage: postImage[0],
                            location: address,
                            secondImage: postImage[1],
                            thirdImage: postImage[2],
                            timekey: new DateTime.now().toString(),
                            title: title,
                            phone: phone.toString(),
                            rating: rating.toString());
                        await DataBase().addNewPost(
                            uid: user.uid,
                            category: category,
                            description: description,
                            firstImage: postImage[0],
                            location: address,
                            secondImage: postImage[1],
                            thirdImage: postImage[2],
                            timekey: new DateTime.now().toString(),
                            title: title,
                            phone: phone.toString(),
                            rating: rating.toString());
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
        onPressed: () {
          firestoreInstance
              .collection("post")
              .getDocuments()
              .then((querySnapshot) {
            querySnapshot.documents.forEach((result) {
              print(result.data);
            });
          });
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
