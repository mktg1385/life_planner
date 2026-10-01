import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/finance_provider.dart';
import '../../../services/navigation_service.dart';
import '../../../providers/reminder_provider.dart';
import '../../../providers/task_provider.dart';
import '../../../providers/water_provider.dart';
import '../../../providers/weather_provider.dart';
import '../../../services/weekly_analytics_service.dart';
import '../../../widgets/dashboard/live_clock_header.dart';
import '../../../widgets/dashboard/weather_card.dart';
import '../../../widgets/dashboard/today_tasks_preview_card.dart';
import '../../../widgets/dashboard/reminder_preview_card.dart';
import '../../../providers/sleep_provider.dart';
import '../../../widgets/dashboard/health_summary_card.dart';
import '../../../widgets/dashboard/weekly_analytics_card.dart';
import '../../../services/streak_service.dart';
import '../../../providers/daily_journal_provider.dart';
import '../../../services/life_score_service.dart';
import '../../../widgets/dashboard/life_score_card.dart';
import '../../../widgets/dashboard/today_finance_card.dart';
import '../../../presentation/pages/finance/add_transaction_page.dart';
import '../../../services/smart_notification_service.dart';
import '../../../services/notification_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await context.read<TaskProvider>().loadTasks();
      await context.read<WeatherProvider>().loadCurrentLocationWeather();
      await StreakService.updateDailyOpen();
      await context.read<ReminderProvider>().loadReminders();
      context.read<DailyJournalProvider>().loadAll();

      context.read<DailyJournalProvider>().loadToday();

      await context.read<WaterProvider>().loadTodayWater();
      await context.read<FinanceProvider>().loadTransactions();

      await context.read<SleepProvider>().loadSleepData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    final reminderProvider = context.watch<ReminderProvider>();

    final waterProvider = context.watch<WaterProvider>();

    final journalProvider = context.watch<DailyJournalProvider>();

    final journal = journalProvider.today;
    final financeProvider = context.watch<FinanceProvider>();
    final dailyJournalProvider = context.watch<DailyJournalProvider>();

    final weatherProvider = context.watch<WeatherProvider>();
    final now = DateTime.now();
    final sleepProvider = context.watch<SleepProvider>();
    final todayTasks = taskProvider.tasks
        .where(
          (e) =>
              e.date.year == now.year &&
              e.date.month == now.month &&
              e.date.day == now.day,
        )
        .toList();

    final completedTasks = todayTasks.where((e) => e.isCompleted).length;

    final todayReminders = reminderProvider.reminders
        .where(
          (e) =>
              e.reminderDateTime.year == now.year &&
              e.reminderDateTime.month == now.month &&
              e.reminderDateTime.day == now.day,
        )
        .toList();
    final lifeScore = LifeScoreService.calculate(
      mood: (journal?.mood ?? 0).toDouble(),
      sleepHours: sleepProvider.averageSleepHours,
      water: waterProvider.glassesCount,
      completedTasks: completedTasks,
      totalTasks: todayTasks.length,
      balance: financeProvider.balance,
    );

    final suggestion = SmartNotificationService.build(
      sleepHours: context.read<SleepProvider>().averageSleepHours,

      water: context.read<WaterProvider>().glassesCount,

      completedTasks: 0,
      totalTasks: 0,

      balance: context.read<FinanceProvider>().balance,

      mood: 3,
    );
    NotificationService.instance.scheduleSmartSuggestion(body: suggestion);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const LiveClockHeader(),
            const SizedBox(height: 20),

            if (weatherProvider.weather != null)
              WeatherCard(
                city: weatherProvider.weather!.city,
                temperature: weatherProvider.weather!.temperature,
                condition: weatherProvider.weather!.condition,
                humidity: weatherProvider.weather!.humidity,
                windSpeed: weatherProvider.weather!.windSpeed,
                source: weatherProvider.weather!.source,
                updatedAt: weatherProvider.weather!.updatedAt,
              ),
            const SizedBox(height: 16),

            HealthSummaryCard(
              sleepHours: journal?.sleepHours ?? 0,

              waterCount: journal?.waterCount ?? 0,

              moodAverage: (journal?.mood ?? 0).toDouble(),

              note: journal?.moodNote,
            ),
            const SizedBox(height: 16),
            TodayTasksPreviewCard(
              tasks: todayTasks,
              onViewAll: () {
                NavigationService.instance.openTasks();
              },
            ),

            const SizedBox(height: 16),
            ReminderPreviewCard(
              reminders: todayReminders,
              onTap: () {
                NavigationService.instance.openReminders();
              },
            ),

            const SizedBox(height: 16),

            TodayFinanceCard(
              income: financeProvider.todayIncome,

              expense: financeProvider.todayExpense,

              onOpenFinance: () {
                NavigationService.instance.openFinance();
              },

              onAddTransaction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddTransactionPage()),
                );
              },
            ),
            const SizedBox(height: 16),

            WeeklyAnalyticsCard(
              data: WeeklyAnalyticsService.build(
                tasks: taskProvider.tasks,
                journals: dailyJournalProvider.journals,
                sleeps: sleepProvider.records,
              ),
            ),
            const SizedBox(height: 24),
            LifeScoreCard(score: lifeScore),
          ],
        ),
      ),
    );
  }
}
