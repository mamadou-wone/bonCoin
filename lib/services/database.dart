import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  final CollectionReference postCollection =
      Firestore.instance.collection('post');

  // Future updateUserData()async{

  // }
}
