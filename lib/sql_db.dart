import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDbf{
  static Database? _db;
  Future <Database?> get db async{
    if (_db == null){
      _db = await intialDb();
      return _db;
    }else{
      return _db;
    }
  }
  intialDb()async{
    String databasepath = await getDatabasesPath();
    String path = join(databasepath , 'nots.db');
    Database mydb = await openDatabase(path , onCreate: _onCreate , version: 5);
    return mydb;
  }
  _onCreate (Database db , int version)async{
    Batch batch =db.batch();
    // await db.execute('''
    batch.execute('''
    CREATE TABLE "Notes"(
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
    "title" TEXT NOT NULL,
    "color" TEXT NOT NULL,
    "note" TEXT NOT NULL 
    )
    ''');
    await batch.commit();
    print("Create DataBase and Table ++++++++++++++++++++++");
  }
  show(String table)async{
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }// SELECT
  insert(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }// INSERT
  updatet(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }// UPDATE
  delete(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }// DELETE

}