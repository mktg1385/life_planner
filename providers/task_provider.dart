import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/models/task_model.dart';
import '../data/repositories/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();

  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> loadTasks() async {
    try {
      _isLoading = true;
      notifyListeners();

      _tasks = await _repository.getTasks();
    } catch (e, s) {
      debugPrint('TASK LOAD ERROR: $e');
      debugPrintStack(stackTrace: s);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await _repository.insertTask(task);
      await loadTasks();
    } catch (e, s) {
      debugPrint('TASK ADD ERROR: $e');
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await _repository.deleteTask(id);
      await loadTasks();
    } catch (e, s) {
      debugPrint('TASK DELETE ERROR: $e');
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await _repository.updateTask(task);
      await loadTasks();
    } catch (e, s) {
      debugPrint('TASK UPDATE ERROR: $e');
      debugPrintStack(stackTrace: s);
    }
  }

  double get progress {
    if (_tasks.isEmpty) {
      return 0;
    }

    final completed = _tasks.where((e) => e.isCompleted).length;

    return completed / _tasks.length;
  }
}
