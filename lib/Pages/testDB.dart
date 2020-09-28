import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}

class DB {
  DB._();
  static final DB db = DB._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Dog ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "age INTEGER,"
          ")");
    });
  }

  Future<void> insertDog(Dog dog) async {
    final Database db = await database;
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Dog>> dogs() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }
}

class TestDog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fido = Dog(
      id: 0,
      name: 'Fido',
      age: 35,
    );
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('tap'),
          onPressed: () async {
            await DB.db.insertDog(fido);
          },
        ),
      ),
    );
  }
}
