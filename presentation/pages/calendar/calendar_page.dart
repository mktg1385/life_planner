import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../core/enums/transaction_type.dart';

import '../../../providers/calendar_provider.dart';
import '../../../providers/daily_journal_provider.dart';
import '../../../providers/finance_provider.dart';
import '../../../providers/reminder_provider.dart';
import '../../../providers/task_provider.dart';

import '../../../widgets/calendar/day_details_sheet.dart';
import '../../../widgets/calendar/persian_calendar_grid.dart';
import '../../../widgets/calendar/persian_calendar_header.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Jalali _month = Jalali.now();

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await context.read<CalendarProvider>().loadEvents();

      await context.read<DailyJournalProvider>().loadAll();

      await context.read<TaskProvider>().loadTasks();

      await context.read<ReminderProvider>().loadReminders();

      await context.read<FinanceProvider>().loadTransactions();
    });
  }

  void _openDayDetails(Jalali jalali) {
    final date = jalali.toDateTime();

    final journalProvider = context.read<DailyJournalProvider>();

    final taskProvider = context.read<TaskProvider>();

    final reminderProvider = context.read<ReminderProvider>();

    final financeProvider = context.read<FinanceProvider>();

    final journalList = journalProvider.journals.where(
      (e) =>
          e.date.year == date.year &&
          e.date.month == date.month &&
          e.date.day == date.day,
    );

    final journal = journalList.isEmpty ? null : journalList.first;

    final tasks = taskProvider.tasks
        .where(
          (e) =>
              e.date.year == date.year &&
              e.date.month == date.month &&
              e.date.day == date.day,
        )
        .toList();

    final reminders = reminderProvider.reminders
        .where(
          (e) =>
              e.reminderDateTime.year == date.year &&
              e.reminderDateTime.month == date.month &&
              e.reminderDateTime.day == date.day,
        )
        .toList();

    final transactions = financeProvider.transactions
        .where(
          (e) =>
              e.transactionDate.year == date.year &&
              e.transactionDate.month == date.month &&
              e.transactionDate.day == date.day,
        )
        .toList();

    final income = transactions
        .where((e) => e.type == TransactionType.income)
        .fold(0.0, (sum, item) => sum + item.amount);

    final expense = transactions
        .where((e) => e.type == TransactionType.expense)
        .fold(0.0, (sum, item) => sum + item.amount);

    final hasData =
        journal != null ||
        tasks.isNotEmpty ||
        reminders.isNotEmpty ||
        transactions.isNotEmpty;

    if (!hasData) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('برای این روز اطلاعاتی ثبت نشده است')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return DayDetailsSheet(
          date: date,

          mood: journal?.mood ?? 0,
          sleepHours: journal?.sleepHours ?? 0,
          waterCount: journal?.waterCount ?? 0,
          note: journal?.moodNote,

          taskCount: tasks.length,
          completedTasks: tasks.where((e) => e.isCompleted).length,

          reminderCount: reminders.length,

          income: income,
          expense: expense,

          tasks: tasks,
          reminders: reminders,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalendarProvider>();

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(title: const Text("تقویم فارسی")),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          PersianCalendarHeader(
            currentMonth: _month,

            onNextMonth: () {
              setState(() {
                _month = _month.addMonths(1);
              });
            },

            onPreviousMonth: () {
              setState(() {
                _month = _month.addMonths(-1);
              });
            },
          ),

          const SizedBox(height: 20),

          PersianCalendarGrid(
            currentMonth: _month,

            selectedDate: provider.selectedDate,

            onDateSelected: (date) {
              provider.selectDate(date);

              _openDayDetails(date);
            },
          ),
        ],
      ),
    );
  }
}
