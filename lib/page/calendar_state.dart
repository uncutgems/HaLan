part of 'calendar_bloc.dart';

@immutable
abstract class CalendarState {}

class CalendarInitial extends CalendarState {
  CalendarInitial(this.dateTime);
  final DateTime dateTime;
}
class CalendarStateShowPickedDate extends CalendarState{
  CalendarStateShowPickedDate(this.pickedDate);
  final DateTime pickedDate;
}
