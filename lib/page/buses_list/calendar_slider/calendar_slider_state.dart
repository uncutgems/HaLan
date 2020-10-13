part of 'calendar_slider_bloc.dart';

@immutable
abstract class CalendarSliderState {}

class CalendarSliderInitial extends CalendarSliderState {
  CalendarSliderInitial(this.date, this.disableValue);
  final DateTime date;
  final bool disableValue;

}

class CallBackCalendarSliderState extends CalendarSliderState{
  CallBackCalendarSliderState(this.date);
  final DateTime date;

}