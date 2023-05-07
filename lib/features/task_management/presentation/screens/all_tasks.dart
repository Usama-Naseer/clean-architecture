import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innovage/features/task_management/domain/models/task_model.dart';
import 'package:innovage/features/task_management/presentation/riverpod/task_riverpod.dart';
import 'package:innovage/features/task_management/presentation/riverpod/task_states.dart';
import 'package:innovage/features/task_management/presentation/widgets/task_tile.dart';
import 'package:innovage/features/task_management/utils/constants/app_strings.dart';
import 'package:innovage/features/task_management/utils/constants/routes.dart';

class AllTasks extends ConsumerStatefulWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  ConsumerState<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends ConsumerState<AllTasks> {
  List<TaskModel> tasks = [];
  @override
  Widget build(BuildContext context) {
    TasksState state = ref.watch(taskStateNotifier);
    if (state is LoadedState) {
      tasks = state.tasks;
    }
    if (state is TaskAdded) {
      tasks.add(state.tasks);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.tasks),
        centerTitle: true,
      ),
      body: ((state is LoadedState && state.tasks.isEmpty))
          ? const Center(child: Text(AppStrings.noTask))
          : (state is LoadingState)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemBuilder: (context, index) => TaskTile(
                    task: tasks[index],
                  ),
                  itemCount: tasks.length,
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addEditRoute);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    ref.read(taskStateNotifier.notifier).getAllTasks();
  }
}
