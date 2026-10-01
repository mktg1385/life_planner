import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/task_model.dart';
import '../../../providers/task_provider.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TaskProvider>().loadTasks();
    });
  }

  Future<void> _showAddTaskDialog() async {
    final titleController = TextEditingController();

    final descriptionController = TextEditingController();

    final provider = context.read<TaskProvider>();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('افزودن وظیفه'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'عنوان'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'توضیحات'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('انصراف'),
            ),
            FilledButton(
              onPressed: () async {
                if (titleController.text.trim().isEmpty) {
                  return;
                }

                final task = TaskModel(
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                  isCompleted: false,
                  date: DateTime.now(),
                  createdAt: DateTime.now(),
                );

                await provider.addTask(task);

                if (!mounted) {
                  return;
                }

                Navigator.pop(context);
              },
              child: const Text('ثبت'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    final today = DateTime.now();

    final todayTasks = provider.tasks
        .where(
          (e) =>
              e.date.year == today.year &&
              e.date.month == today.month &&
              e.date.day == today.day,
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('وظایف')),
      floatingActionButton: FloatingActionButton(
        heroTag: 'tasksFab',
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : todayTasks.isEmpty
          ? const Center(child: Text('وظیفه‌ای برای امروز ثبت نشده است'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: todayTasks.length,
              itemBuilder: (context, index) {
                final task = todayTasks[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) async {
                        await provider.updateTask(
                          task.copyWith(isCompleted: value ?? false),
                        );
                      },
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: task.description == null
                        ? null
                        : Text(task.description!),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        if (task.id == null) {
                          return;
                        }

                        await provider.deleteTask(task.id!);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
