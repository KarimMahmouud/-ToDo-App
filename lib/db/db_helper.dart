import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '/models/task.dart';

class DBHelper {
  static Database? db;
  static const int version = 1;
  static const String tableName = 'tasks';

  static Future<void> iniDb() async {
    try {
      // ignore: avoid_print
      print('Creating database...');
      String path = join(await getDatabasesPath(), 'my_database.db');

      db = await openDatabase(
        path,
        version: version,
        onCreate: (Database db, int version) async {
          // ignore: avoid_print
          print('Creating new table...');
          await db.execute('CREATE TABLE $tableName ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'title TEXT, note TEXT, date TEXT, startTime TEXT, endTime TEXT, '
              'remind INTEGER, repeat TEXT, '
              'color INTEGER, isCompleted INTEGER)');
        },
      );
      // ignore: avoid_print
      print('Database created');
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  // static Future<void> deleteDatabase() async {
  //   try {
  //     String path = join(await getDatabasesPath(), 'my_database.db');
  //     await deleteDatabase(path);
  //     print('Database deleted');
  //   } catch (e) {
  //     print('Error deleting database: $e');
  //   }
  // }

  static Future<int> insert(Task task) async {
    // ignore: avoid_print
    print('Insert function called');
    try {
      return await db!.insert(tableName, task.toJson());
    } catch (e) {
      // ignore: avoid_print
      print('Error inserting task: $e');
      return -1;
    }
  }

  static Future<int> delete(Task task) async {
    // ignore: avoid_print
    print('Delete function called');
    return await db!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<int> deleteAll() async {
    // ignore: avoid_print
    print('DeleteAll function called');
    return await db!.delete(tableName);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    // ignore: avoid_print
    print('Query function called');
    return await db!.query(
      tableName,
    );
  }

  static update(int id) async {
    // ignore: avoid_print
    print('Update function called');
    return await db!.rawUpdate('''
        UPDATE tasks
        SET isCompleted = ?
        WHERE id = ?
      ''', [1, id]);
  }
}
