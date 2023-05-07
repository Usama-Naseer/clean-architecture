import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innovage/features/task_management/domain/models/task_model.dart';
import 'package:innovage/features/task_management/presentation/riverpod/task_riverpod.dart';

import '../../utils/constants/routes.dart';

class TaskTile extends ConsumerWidget {
  const TaskTile({required this.task, Key? key}) : super(key: key);
  final TaskModel task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 1),
              color: Colors.black.withOpacity(0.5),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(task.id),
          Text(task.name),
          Text(task.date),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.addEditRoute,
                  arguments: task);
            },
            child: const Icon(Icons.edit),
          ),
          GestureDetector(
            onTap: () {
              ref.read(taskStateNotifier.notifier).deleteTask(task.id);
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
