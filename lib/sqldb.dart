import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'wael.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 10, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    print("onUpgrade =====================================");
    await db.execute(''' 
    ALTER TABLE  notes ADD COLUMN color TEXT 
    
        ''');
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "note" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "color" TEXT NOT NULL,
    "position" INTEGER NOT NULL,
  )
 ''');

    await batch.commit();
    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

// SELECT
// DELETE
// UPDATE
// INSERT
  deleteDatabases() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'wael.db');
    await deleteDatabase(path);
  }

  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insert(String table, Map<String, Object?> value) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, value);
    return response;
  }

  update(String table, Map<String, Object?> value, String? mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, value, where: mywhere);
    return response;
  }

  delete(String table, String? mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: mywhere);
    return response;
  }

  Future<int> getTotal() async {
    Database? mydb = await db;
    List<Map<String, dynamic>> notes =
        await mydb!.query('notes', columns: ['note']);
    int total = notes
        .map((note) => note['note'] as int)
        .reduce((sum, note) => sum + note);
    return total;
  }
}
