import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innovage/features/task_management/domain/models/task_model.dart';
import 'package:innovage/features/task_management/presentation/riverpod/task_riverpod.dart';
import 'package:innovage/features/task_management/presentation/riverpod/task_states.dart';
import 'package:innovage/features/task_management/utils/constants/app_strings.dart';

class AddEditTask extends ConsumerWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  AddEditTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arguments = ModalRoute.of(context)?.settings.arguments as TaskModel?;
    _nameController.text = arguments?.name ?? '';
    _dateController.text = arguments?.date ?? '';
    _idController.text = arguments?.id ?? '';
    TasksState state = ref.watch(taskStateNotifier);
    if (state is TaskAdded || state  is LoadedState) {
      _nameController.clear();
      _idController.clear();
      _dateController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments == null ? AppStrings.add : AppStrings.edit),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: _idController,
              decoration: const InputDecoration(hintText: AppStrings.num),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: AppStrings.name),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _dateController,
              decoration: const InputDecoration(hintText: AppStrings.date),
            ),
            const SizedBox(
              height: 10,
            ),
            state is LoadingState?
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      if (arguments == null) {
                        ref.read(taskStateNotifier.notifier).addTask(TaskModel(
                            id: _idController.text,
                            name: _nameController.text,
                            date: _dateController.text));
                      } else {
                        ref.read(taskStateNotifier.notifier).editTask(
                            TaskModel(
                              id: _idController.text,
                              name: _nameController.text,
                              date: _dateController.text,
                            ),
                            arguments.id);
                      }
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(
                          child: Text(arguments == null
                              ? AppStrings.add
                              : AppStrings.edit)),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
