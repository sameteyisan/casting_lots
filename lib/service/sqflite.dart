import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//if not exists
const String tableName = "KuraCek";
// ignore: non_constant_identifier_names
const String columnId = "ID";
// ignore: non_constant_identifier_names
const String columnKuraList = "KuraList";
// ignore: non_constant_identifier_names
const String columnName = "name";

class TaskModel {
  final String name;
  final String kuraList;
  int? id;

  TaskModel({
    required this.kuraList,
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      columnName: name,
      columnKuraList: kuraList,
    };
  }
}

class TodoHelper {
  Database? db;

  TodoHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "databse.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnName TEXT, $columnKuraList TEXT)");
    }, version: 1);
  }

  Future<void> insertTask(TaskModel task) async {
    try {
      db!.insert(tableName, task.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {}
  }

  Future<void> deleteTask(int x) async {
    try {
      db!.execute(
        'DELETE FROM $tableName WHERE $columnId = ? ',
        [x],
      );
    } catch (_) {}
  }

  Future<List<TaskModel>> getAllTask() async {
    final List<Map<String, dynamic>> tasks = await db!.query(tableName);

    return List.generate(tasks.length, (i) {
      return TaskModel(
        name: tasks[i][columnName],
        kuraList: tasks[i][columnKuraList],
        id: tasks[i][columnId],
      );
    });
  }
}
