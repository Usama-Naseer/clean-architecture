import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innovage/features/task_management/data/local/local_task_repository.dart';
import 'package:innovage/features/task_management/domain/models/task_model.dart';
import 'package:innovage/features/task_management/domain/repositories/task_respository.dart';
import 'package:innovage/features/task_management/presentation/riverpod/task_states.dart';

class TaskProvider extends StateNotifier<TasksState> {
  TaskProvider() : super(LoadingState());
  final TaskRepository _repository = LocalTaskRepository();
  List<TaskModel> tasks = [];

  void getAllTasks() async {
    try {
      LoadingState();
      tasks.addAll(await _repository.getAllTasks());
      state = LoadedState(tasks);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void addTask(TaskModel task) async {
    try {
      state = LoadingState();
      await _repository.addTask(task);
      state = TaskAdded(task);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteTask(String id) async {
    try {
      state = LoadingState();
      await _repository.deleteTask(id);
      tasks.removeWhere((element) => element.id == id);
      state = LoadedState(tasks);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void editTask(TaskModel task, String id) async {
    try {
      state = LoadingState();
      await _repository.editTask(task, id);
      int index = tasks.indexWhere((element) => element.id == id);
      if (index >= 0) {
        tasks[index] = task;
        state = LoadedState(tasks);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

final taskStateNotifier =
    StateNotifierProvider<TaskProvider, TasksState>((ref) {
  return TaskProvider();
});
