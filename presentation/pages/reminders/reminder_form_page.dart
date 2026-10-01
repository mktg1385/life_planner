import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/repeat_type.dart';
import '../../../data/models/reminder_model.dart';
import '../../../providers/reminder_provider.dart';
import '../../../widgets/common/persian_date_time_picker.dart';

class ReminderFormPage extends StatefulWidget {
  const ReminderFormPage({super.key});

  @override
  State<ReminderFormPage> createState() => _ReminderFormPageState();
}

class _ReminderFormPageState extends State<ReminderFormPage> {
  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();

  DateTime _selectedDateTime = DateTime.now().add(const Duration(hours: 1));

  RepeatType _repeatType = RepeatType.none;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_titleController.text.trim().isEmpty) {
      return;
    }

    final reminder = ReminderModel(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      reminderDateTime: _selectedDateTime,
      repeatType: _repeatType,
      isActive: true,
      createdAt: DateTime.now(),
    );

    await context.read<ReminderProvider>().addReminder(reminder);

    if (!mounted) return;

    Navigator.pop(context);
  }

  Future<void> _pickDateTime() async {
    final result = await showPersianDateTimePicker(
      context,
      initialDateTime: _selectedDateTime,
    );

    if (result == null) return;

    setState(() {
      _selectedDateTime = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final jalaliDate = Jalali.fromDateTime(_selectedDateTime);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('افزودن یادآوری')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'عنوان'),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'توضیحات'),
          ),

          const SizedBox(height: 20),

          Card(
            elevation: theme.brightness == Brightness.light ? 1 : 0,
            color: colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              leading: Icon(Icons.schedule, color: colorScheme.primary),
              title: const Text('زمان یادآوری'),
              subtitle: Text(
                '${jalaliDate.formatCompactDate()}'
                ' - '
                '${_selectedDateTime.hour.toString().padLeft(2, '0')}:'
                '${_selectedDateTime.minute.toString().padLeft(2, '0')}',
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
              trailing: Icon(Icons.edit_calendar, color: colorScheme.primary),
              onTap: _pickDateTime,
            ),
          ),

          const SizedBox(height: 20),

          DropdownButtonFormField<RepeatType>(
            initialValue: _repeatType,
            decoration: const InputDecoration(labelText: 'نوع تکرار'),
            items: RepeatType.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(switch (e) {
                      RepeatType.none => 'بدون تکرار',
                      RepeatType.daily => 'روزانه',
                      RepeatType.weekly => 'هفتگی',
                      RepeatType.monthly => 'ماهانه',
                    }),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }

              setState(() {
                _repeatType = value;
              });
            },
          ),

          const SizedBox(height: 32),

          FilledButton(onPressed: _save, child: const Text('ثبت یادآوری')),
        ],
      ),
    );
  }
}
