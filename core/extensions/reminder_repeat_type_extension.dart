import '../enums/repeat_type.dart';

extension RepeatTypeExtension on RepeatType {
  String get persianTitle {
    switch (this) {
      case RepeatType.none:
        return 'بدون تکرار';

      case RepeatType.daily:
        return 'روزانه';

      case RepeatType.weekly:
        return 'هفتگی';

      case RepeatType.monthly:
        return 'ماهانه';
    }
  }
}
