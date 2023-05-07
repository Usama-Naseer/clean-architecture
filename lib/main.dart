import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innovage/features/task_management/presentation/screens/add_edit_task.dart';
import 'package:innovage/features/task_management/presentation/screens/all_tasks.dart';
import 'features/task_management/utils/constants/routes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {Routes.addEditRoute: (context) => AddEditTask()},
      home: const AllTasks(),
    );
  }
}
