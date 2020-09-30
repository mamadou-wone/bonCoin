import 'dart:io';
import 'dart:async';
import 'package:bonCoin/Pages/CientTest.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE Client(id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, blocked BIT) ");
    });
  }

  // Make my presentation for toom

  newClient(Client newClient) async {
    final db = await database;
    // var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Client");
    // int id = table.first["id"];
    var res = await db.rawInsert(
        "INSERT INTO Client (last_name)"
        "VALUES (?)",
        [newClient.lastName]);
    return res;
  }

  getAllClient() async {
    final db = await database;
    var res = await db.query("Client");
    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }
}
