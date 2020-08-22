import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  final String uid;
  DataBase({this.uid});
  final CollectionReference postCollection =
      Firestore.instance.collection('post');

  Future updateUserData(
      String timekey,
      String title,
      String description,
      String location,
      String category,
      String firstImage,
      String secondImage,
      String thirdImage) async {
    return await postCollection.document(uid).setData({
      'timeKey': timekey,
      'title': title,
      'description': description,
      'location': location,
      'category': category,
      'firstIage': firstImage,
      'secondImage': secondImage,
      'thirdImage': thirdImage
    });
  }

  Future addData(
    String timekey,
    String title,
  ) async {
    var data = {
      'timeKey': timekey,
      'title': title,
    };
    return await postCollection.document(uid).parent().add(data);
  }
}
