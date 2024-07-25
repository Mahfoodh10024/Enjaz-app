import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dataBase{
  static Database? _dB;

  Future<Database?> get dB async{
    if(_dB == null){
      _dB = await initailDatabase();
      return _dB;
    }
    else{
      return _dB;
    }
  }

  initailDatabase() async{
    var dBpath = await getDatabasesPath();
    var path = join(dBpath , 'User');
    Database mydB = await openDatabase(path , onCreate: _oncreate, onUpgrade: _onupgrade, version: 1);
    return mydB;
  }


  _onupgrade(Database db ,int oldver,int newver){
   print("Upgraded");
  }

  _oncreate(Database db , int version) async{
      await db.execute('''
         CREATE TABLE "user" (
           "id" INTEGER PRIMARY KEY,
           "name" TEXT ,
           "phone" TEXT ,
           "email" TEXT 
         )
      ''');

      await db.execute('''
      Create TABLE "activity"(
        "id" INTEGER PRIMARY KEY ,
        "user_id" INTEGER NOT NULL,
        "achieved" TEXT ,
        "priority" TEXT ,
        "activity_name" TEXT ,
        "activity_type" TEXT ,
        "activity_date" TEXT ,
        "activity_day"  TEXT ,
        "activity_time" TEXT ,
        "work_side"     TEXT ,
        FOREIGN KEY ("user_id") REFERENCES "user"("id") 
       )
      ''');

      await db.execute('''
      Create TABLE "work_side"(
        "id" INTEGER PRIMARY KEY ,
        "user_id" INTEGER NOT NULL,
        "work_side_name" TEXT,
        "location" TEXT    ,
        "description" TEXT ,
        "note" TEXT ,
        FOREIGN KEY ("user_id") REFERENCES "user"("id") 
       )
      ''');

      await db.execute('''
      Create TABLE "deleted_side"(
        "id" INTEGER PRIMARY KEY ,
        "user_id" INTEGER NOT NULL,
        "work_side_name" TEXT,
        "location" TEXT    ,
        "description" TEXT ,
        "note" TEXT 
       )
      ''');


      await db.execute('''
      Create TABLE "finished"(
        "id" INTEGER PRIMARY KEY ,
        "priority" TEXT ,
        "achieved" TEXT ,
        "activity_name" TEXT ,
        "activity_type" TEXT ,
        "activity_date" TEXT ,
        "activity_day"  TEXT ,
        "activity_time" TEXT ,
        "work_side"     TEXT 
       )
      ''');

      await db.execute('''
      Create TABLE "deleted"(
        "id" INTEGER PRIMARY KEY ,
        "priority" TEXT ,
        "achieved" TEXT ,
        "activity_name" TEXT ,
        "activity_type" TEXT ,
        "activity_date" TEXT ,
        "activity_day"  TEXT ,
        "activity_time" TEXT ,
        "work_side"     TEXT 
       )
      ''');



      print("Table has Created");
  }

  closeDB(dataBase db){
    db.closeDB(db);
  }

  insertData(String table , Map<String, dynamic> values) async{
    initailDatabase();
    Database? mydB = await dB;
    int res = await mydB!.insert(table , values);
    return res;
  }

  readData(String sql) async{
    Database? mydB = await dB;
    List<Map> res = await mydB!.rawQuery(sql);
    return res;
  }

  deleteData(String sql, List<dynamic> list) async{
    Database? mydB = await dB;
    int res = await mydB!.rawDelete(sql, list);
    return res;
  }

  deleteAll(String sql) async{
    Database? mydB = await dB;
    int res = await mydB!.rawDelete(sql);
    return res;
  }

  update(String sql, List<String> list) async {
    Database? mydB = await dB;
    int res = await mydB!.rawUpdate(sql , list);
    return res;
  }


  Query(String table) async{
    Database? mydB = await dB;
    List<Map> res = await mydB!.query(table);
    return res;
  }


  Future<List<String>> Showtables()async{
    final db  = await openDatabase('/data/data/com.example.tasks/databases/User');
    final List<Map<String, Object?>> tab = await db.query(
        'sqlite_master',
        where: 'type = ?',
        whereArgs: ['table']
    );
    print(tab);
    return tab.map((tabs) => tabs['sql'] as String).toList();
  }


  Future<List<Map<String, dynamic>>> getForeignKeys() async {
    final db = await openDatabase('/data/data/com.example.tasks/databases/User'); // Replace with your path

    try {
      final List<Map<String, dynamic>> results = await db.rawQuery(
          'SELECT * FROM sqlite_master WHERE type = \'index\''); // Query for indexes
      print(results.where((row) => row['name']?.contains('fk_') == true).toList());
    } catch (e) {
      print('Error getting foreign keys: $e');
    }

    return []; // No foreign keys found or error occurred
  }


}