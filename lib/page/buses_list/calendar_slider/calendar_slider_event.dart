part of 'calendar_slider_bloc.dart';

@immutable
abstract class CalendarSliderEvent {}

class ChoosingDateCalendarSliderEvent extends CalendarSliderEvent {
  ChoosingDateCalendarSliderEvent(this.date);

  final DateTime date;
}

class DisableCalendarSliderEvent extends CalendarSliderEvent {
  DisableCalendarSliderEvent(this.disableValue);

  final bool disableValue;
}
