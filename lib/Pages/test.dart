import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class DBProvider {
  // EXAM REVISON
  // 17/09/20
  // 18/09/20
  // 19/09/20
  // 20/09/20
  // 21/09/20
  // 22/09/20
  // 23/09/20
  // 23/09/20
  // 25/09/20
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, int version) async {
        await db.execute(
            "CREATE TABLE CLIENT ('id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, blocked BIT')");
      },
    );
  }

  newClient(Client newClient) async {
    final db = await database;
    var res = await db.insert(
      "Client",
      newClient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  getClient(int id) async {
    final db = await database;
    var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Client.fromMap(res.first) : null;
  }

  getAllClient() async {
    final db = await database;
    var res = await db.query("Client");
    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Client>> getBlockedClient() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('Client');
    return List.generate(maps.length, (i) {
      return Client(
          id: maps[i]['id'],
          firstName: maps[i]['firstName'],
          lastName: maps[i]['lastName'],
          blocked: maps[i]['blocked']);
    });
    //     return List.generate(maps.length, (i) {
    //   return Dog(
    //     id: maps[i]['id'],
    //     name: maps[i]['name'],
    //     age: maps[i]['age'],
    //   );
    // });

    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked =1");
    // List<Client> list =
    //     res.isNotEmpty ? res.toList().map((e) => Client.fromMap(e)) : null;
    // return list;
  }

  deleteClient(int id) async {
    final db = await database;
    db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("DELETE * FROM Client");
  }
}

class Client {
  int id;
  String firstName;
  String lastName;
  bool blocked;

  Client({this.id, this.firstName, this.lastName, this.blocked});

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        blocked: json["blocked"] == 1,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "firstNname": firstName,
        "lastNname": lastName,
        "blocked": blocked
      };

  static List<Client> testClient = <Client>[
    Client(id: 1, firstName: "Raouf", lastName: "Rahiche", blocked: false),
    Client(firstName: "Zaki", lastName: "oun", blocked: true),
    Client(firstName: "oussama", lastName: "ali", blocked: false),
  ];
}

class ClientPreview extends StatefulWidget {
  @override
  _ClientPreviewState createState() => _ClientPreviewState();
}

class _ClientPreviewState extends State<ClientPreview> {
  List<Client> listClient = Client.testClient;
  Client client =
      Client(id: 1, firstName: "Raouf", lastName: "Rahiche", blocked: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test DB'),
      ),
      // body: Row(
      //   children: [
      //     FlatButton(
      //       child: Text('Display'),
      //       onPressed: () async {
      //         print(await DBProvider.db.getAllClient());
      //       },
      //     ),
      //     FlatButton(
      //       child: Text('Insert'),
      //       onPressed: () async {
      //         await DBProvider.db.newClient(client);
      //       },
      //     )
      //   ],
      // ),
      body: FutureBuilder<List<Client>>(
        future: DBProvider.db.getAllClient(),
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Client item = snapshot.data[index];
                return Center(
                  child: FlatButton(
                    onPressed: () {},
                    child: Text('tap'),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
