import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/reminder_provider.dart';
import '../../../widgets/reminders/reminder_card.dart';
import 'reminder_form_page.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ReminderProvider>().loadReminders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReminderProvider>();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final today = DateTime.now();

    final todayReminders = provider.reminders
        .where(
          (e) =>
              e.reminderDateTime.year == today.year &&
              e.reminderDateTime.month == today.month &&
              e.reminderDateTime.day == today.day,
        )
        .toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text('یادآوری‌ها'),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: 'remindersFab',
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReminderFormPage()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : todayReminders.isEmpty
          ? Center(
              child: Text(
                'یادآوری برای امروز ثبت نشده است',
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 15,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: todayReminders.length,
              itemBuilder: (context, index) {
                final reminder = todayReminders[index];

                return ReminderCard(
                  reminder: reminder,
                  onTap: () {},
                  onDelete: () async {
                    if (reminder.id == null) {
                      return;
                    }

                    await provider.deleteReminder(reminder.id!);
                  },
                );
              },
            ),
    );
  }
}
