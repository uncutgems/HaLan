import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/model/entity.dart';
import 'package:meta/meta.dart';

part 'bus_booking_event.dart';
part 'bus_booking_state.dart';

class BusBookingBloc extends Bloc<BusBookingEvent, BusBookingState> {
  BusBookingBloc() : super(DisplayDataBusBookingState(DateTime.now(),const <Point>[]));

  @override
  Stream<BusBookingState> mapEventToState(
    BusBookingEvent event,
  ) async* {
    if(event is GetDataBusBookingEvent){
      yield DisplayDataBusBookingState(event.date,event.selectedPoints);
    }
  }
}
