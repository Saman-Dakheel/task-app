import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_app/model/task.dart';

class DatabaseHelper {
  bool isLoaded = false;
  static const String dbName = "task.db";
  static const String tableName = "tasks";
  static const String columnId = "id";
  static const String columnTitle = "title";
  static const String columnDescription = "description";
  Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  initDatabase() async {
    final databasePath = await getDatabasesPath();
    final String path = join(databasePath, dbName);
    final Database mydb =
        await openDatabase(path, version: 1, onCreate: onCreated);

    return mydb;
  }

  onCreated(Database mydb, int version) async {
    await mydb.execute('''
CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnTitle TEXT, $columnDescription TEXT)
''');
    print(" Table created !!!!!!!!!!!!!!!!!!!!!!!!!! ");
  }

  Future<List<Map>> getAllTasks() async {
    Database mydb = await db as Database;
    final List<Map<String, dynamic>> maps = await mydb.query(tableName);
    return maps;
    // return List.generate(maps.length, (i) {
    //   return Task(
    //     id: maps[i][columnId],
    //     title: maps[i][columnTitle],
    //     description: maps[i][columnDescription],
    //   );
    // });
  }

  insertTask(Task task) async {
    Database mydb = await db as Database;
    await mydb.insert(
      tableName,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("inserted !!!!!!!!!!!!!!!!!!!!!!");
  }

  deleteData(int id) async {
    Database mydb = await db as Database;
    await mydb.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    print("Deleted !!!!!!!!!!!!!!!!!!!!!!");
  }

  Future<int> updateData(Task task) async {
    Database mydb = await db as Database;
    int response = await mydb.update(tableName, task.toMap(),
        where: '$columnId = ?',
        conflictAlgorithm: ConflictAlgorithm.replace,
        whereArgs: [task.id]);
    print("Updated !!!!!!!!!!!!!!!!!!!!!!");
    return response;
  }
}
