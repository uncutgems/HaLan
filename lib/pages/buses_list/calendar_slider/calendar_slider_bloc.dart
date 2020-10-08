import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calendar_slider_event.dart';
part 'calendar_slider_state.dart';

class CalendarSliderBloc extends Bloc<CalendarSliderEvent, CalendarSliderState> {
  CalendarSliderBloc() : super(CalendarSliderInitial());

  @override
  Stream<CalendarSliderState> mapEventToState(
    CalendarSliderEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
