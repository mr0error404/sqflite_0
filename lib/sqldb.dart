import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDb{
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
    Database mydb = await openDatabase(path , onCreate: _onCreate , version: 2,  onUpgrade: _onUpgrade);
    return mydb;
  }
  _onCreate (Database db , int version)async{
    await db.execute('''
    CREATE TABLE "Notes"(
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
    "note" TEXT NOT NULL 
    )
    ''');
    print("Create DataBase and Table ++++++++++++++++++++++");
  }
  showData(String sql)async{
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }// SELECT
  insertData(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }// INSERT
  updatetData(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }// UPDATE
  deleteData(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }// DELETE
  _onUpgrade(Database db, int oldverstion, int newverstion){
    print("onUpgrade ====++++");
  }
}