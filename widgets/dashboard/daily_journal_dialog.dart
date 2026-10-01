import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/daily_journal_provider.dart';

class DailyJournalDialog extends StatefulWidget {
  const DailyJournalDialog({
    super.key,
  });

  @override
  State<DailyJournalDialog> createState() =>
      _DailyJournalDialogState();
}

class _DailyJournalDialogState
    extends State<DailyJournalDialog> {
  int mood = 3;

  int water = 0;

  double sleepHours = 8;

  final noteController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'ثبت وضعیت امروز',
      ),

      content: SingleChildScrollView(
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            const Align(
              alignment:
                  Alignment.centerRight,
              child: Text(
                'حال روز',
              ),
            ),

            Slider(
              value: mood.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: mood.toString(),
              onChanged: (v) {
                setState(() {
                  mood = v.toInt();
                });
              },
            ),

            const SizedBox(height: 16),

            TextField(
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    'تعداد لیوان آب',
              ),
              onChanged: (v) {
  final value =
      int.tryParse(v) ?? 0;

  water = value.clamp(0, 8);
},
            ),

            const SizedBox(height: 16),

            TextField(
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    'ساعت خواب',
              ),
              onChanged: (v) {
                sleepHours =
                    double.tryParse(v) ??
                        8;
              },
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  noteController,
              maxLines: 4,
              decoration:
                  const InputDecoration(
                labelText:
                    'یادداشت روز',
              ),
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'انصراف',
          ),
        ),

        FilledButton(
          onPressed: () async {
            await context
                .read<
                    DailyJournalProvider>()
                .save(
                  mood: mood,
                  water: water,
                  sleepHours:
                      sleepHours,
                  note:
                      noteController.text,
                );

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text(
            'ذخیره',
          ),
        ),
      ],
    );
  }
}