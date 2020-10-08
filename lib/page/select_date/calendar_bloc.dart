import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial(DateTime.now()));

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if(event is CalendarEventClickMonth){
      yield CalendarInitial(event.date);
    }
    else if (event is CalendarEventClickDay){
      yield CalendarStateShowPickedDate(event.pickedDate);
    }
  }
}
