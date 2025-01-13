import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  DateTime now = DateTime.now();

  if (DateFormat('yyyy-MM-dd').format(dateTime) == DateFormat('yyyy-MM-dd').format(now)) {
    return "Today • ${DateFormat('hh:mm a').format(dateTime)}";
  }

  if (DateFormat('yyyy-MM-dd').format(dateTime) ==
      DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 1)))) {
    return "Yesterday • ${DateFormat('hh:mm a').format(dateTime)}";
  }

  return DateFormat('dd MMM yyyy • hh:mm a').format(dateTime);
}
