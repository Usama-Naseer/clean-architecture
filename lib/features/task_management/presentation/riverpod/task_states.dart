import 'package:equatable/equatable.dart';
import 'package:innovage/features/task_management/domain/models/task_model.dart';

abstract class TasksState extends Equatable {}

class LoadingState extends TasksState {
  @override
  List<Object> get props => [];
}

class LoadedState extends TasksState {
  final List<TaskModel> tasks;
  LoadedState(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskAdded extends TasksState {
  final TaskModel tasks;
  TaskAdded(this.tasks);

  @override
  List<Object> get props => [];
}
