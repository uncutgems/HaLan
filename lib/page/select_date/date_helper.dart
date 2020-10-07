import 'package:date_util/date_util.dart';

List<DateTime> getDateList(
  DateTime firstDate,
  DateTime lastDate,
) {
  final DateUtil dateUtility = DateUtil();
  final List<DateTime> list = <DateTime>[toDateMonthYear(firstDate)];
  while (list.last.compareTo(toDateMonthYear(lastDate)) == -1) {
    list.add(toDateMonthYear(list.last.add( Duration(days: dateUtility.daysInMonth(list.last.month, list.last.year) as int))));
  }
  return list;
}

DateTime toDateMonthYear(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

enum LabelType {
  date,
  month,
  weekday,
}
