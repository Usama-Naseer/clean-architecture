import 'package:innovage/features/task_management/domain/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getAllTasks();
  Future<void> addTask(TaskModel task);
  Future<void> editTask(TaskModel task, String id);
  Future<void> deleteTask(String id);
}
