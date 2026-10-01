import '../data/models/task_model.dart';

class DashboardStatisticsService {
  DashboardStatisticsService._();

  static int completedTasks(
    List<TaskModel> tasks,
  ) {
    return tasks
        .where(
          (e) => e.isCompleted,
        )
        .length;
  }

  static int pendingTasks(
    List<TaskModel> tasks,
  ) {
    return tasks
        .where(
          (e) => !e.isCompleted,
        )
        .length;
  }

  static double taskProgress(
    List<TaskModel> tasks,
  ) {
    if (tasks.isEmpty) {
      return 0;
    }

    return completedTasks(tasks) /
        tasks.length;
  }
}