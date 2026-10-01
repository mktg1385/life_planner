class LifeScoreService {
  static double calculate({
    required double mood,
    required double sleepHours,
    required int water,
    required int completedTasks,
    required int totalTasks,
    required double balance,
  }) {
    double score = 0;

    // Mood (20%)
    score += (mood / 5) * 20;

    // Sleep (15%)
    score += (sleepHours >= 7 ? 1 : sleepHours / 7) * 15;

    // Water (10%)
    score += (water >= 8 ? 1 : water / 8) * 10;

    // Tasks (20%)
    if (totalTasks > 0) {
      score += (completedTasks / totalTasks) * 20;
    }


    // Finance stability (20%)
    score += (balance >= 0 ? 1 : 0.5) * 20;

    return score.clamp(0, 100);
  }
}