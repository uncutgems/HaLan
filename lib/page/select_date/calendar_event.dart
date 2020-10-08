part of 'calendar_bloc.dart';

@immutable
abstract class CalendarEvent {}
class CalendarEventClickMonth extends CalendarEvent{
  CalendarEventClickMonth(this.date);
  final DateTime date;
}
class CalendarEventClickDay extends CalendarEvent{
  CalendarEventClickDay(this.pickedDate);
  final DateTime pickedDate;
}