import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calendar_slider_event.dart';
part 'calendar_slider_state.dart';

class CalendarSliderBloc extends Bloc<CalendarSliderEvent, CalendarSliderState> {
  CalendarSliderBloc() : super(CalendarSliderInitial(DateTime(0), false));

  @override
  Stream<CalendarSliderState> mapEventToState(
    CalendarSliderEvent event,
  ) async* {
    final CalendarSliderState currentState = state;
    if(event is ChoosingDateCalendarSliderEvent) {
      yield CallBackCalendarSliderState(event.date);
      yield CalendarSliderInitial(event.date, false);
    }
    if (currentState is CalendarSliderInitial) {
      if (event is DisableCalendarSliderEvent) {
        print('disable vafo day ${event.disableValue}');
        yield CalendarSliderInitial(currentState.date, event.disableValue);
      }
    }
  }
}
