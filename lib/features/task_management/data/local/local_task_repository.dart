import 'package:innovage/features/task_management/domain/models/task_model.dart';
import 'package:innovage/features/task_management/domain/repositories/task_respository.dart';
import 'package:sqflite/sqflite.dart';

class LocalTaskRepository implements TaskRepository {
  @override
  Future<void> addTask(TaskModel task) async {
    var db = await openDatabase('my_db.db', singleInstance: true);
    var taskTable =
        await db.rawQuery('SELECT * FROM sqlite_master WHERE name="tasks";');
    if (taskTable.isEmpty) {
      String createTable =
          "CREATE TABLE tasks (id Text PRIMARY KEY,name Text,date Text)";
      await db.execute(createTable);
    }
    await db.rawInsert(
        "INSERT INTO tasks(id,name,date) VALUES('${task.id}','${task.name}','${task.date}')");
  }

  @override
  Future<void> deleteTask(String id) async {
    var db = await openDatabase('my_db.db', singleInstance: true);
    await db.rawQuery(
        'DELETE FROM tasks WHERE id="$id";'); // TODO: implement deleteTask
  }

  @override
  Future<void> editTask(TaskModel task, String id) async {
    var db = await openDatabase('my_db.db', singleInstance: true);
    await db.update('tasks', task.toJson(), where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    var db = await openDatabase('my_db.db', singleInstance: true);
    var taskTales =
        await db.rawQuery('SELECT * FROM sqlite_master WHERE name="tasks";');
    List<Map<String, dynamic>> results;
    if (taskTales.isNotEmpty) {
      results = await db.rawQuery('SELECT * from tasks');
      List<TaskModel> tasks =
          (results).map((e) => TaskModel.fromJson(e)).toList();
      return tasks;
    }
    return [];
  }
}
