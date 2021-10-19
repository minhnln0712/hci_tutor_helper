import 'package:intl/intl.dart';

class AppDateTimeFormat {
  static DateFormat dateOfWeekFormat = DateFormat('EEE');
  static DateFormat dateFormat = DateFormat('d MMM');
  static DateFormat monthFormat = DateFormat('MMM');
  static DateFormat yearFormat = DateFormat('y');
  static DateFormat dateOfWeekForCalendarFormat = DateFormat('E');
  static DateFormat dayForCalendarFormat = DateFormat('d');
  static DateFormat timeFormat = DateFormat('jm');
}
