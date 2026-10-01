import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersianTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;

  const PersianTimePicker({super.key, required this.initialTime});

  @override
  State<PersianTimePicker> createState() => _PersianTimePickerState();
}

class _PersianTimePickerState extends State<PersianTimePicker> {
  late int hour;
  late int minute;

  @override
  void initState() {
    super.initState();

    hour = widget.initialTime.hour;
    minute = widget.initialTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: SizedBox(
        height: 360,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text('انتخاب ساعت', style: theme.textTheme.titleLarge),

              const SizedBox(height: 20),

              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 42,
                        scrollController: FixedExtentScrollController(
                          initialItem: hour,
                        ),
                        onSelectedItemChanged: (value) {
                          setState(() {
                            hour = value;
                          });
                        },
                        children: List.generate(
                          24,
                          (index) => Center(
                            child: Text(index.toString().padLeft(2, '0')),
                          ),
                        ),
                      ),
                    ),

                    const Text(
                      ":",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 42,
                        scrollController: FixedExtentScrollController(
                          initialItem: minute,
                        ),
                        onSelectedItemChanged: (value) {
                          setState(() {
                            minute = value;
                          });
                        },
                        children: List.generate(
                          60,
                          (index) => Center(
                            child: Text(index.toString().padLeft(2, '0')),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pop(TimeOfDay(hour: hour, minute: minute));
                  },
                  child: const Text('تأیید'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
