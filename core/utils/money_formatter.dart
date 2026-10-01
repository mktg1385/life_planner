import 'package:intl/intl.dart';

class MoneyFormatter {
  static String format(num value) {
    final formatter = NumberFormat('#,###');

    return '${formatter.format(value)} تومان';
  }
}