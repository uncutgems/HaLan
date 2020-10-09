import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bus_booking_event.dart';
part 'bus_booking_state.dart';

class BusBookingBloc extends Bloc<BusBookingEvent, BusBookingState> {
  BusBookingBloc() : super(BusBookingInitial());

  @override
  Stream<BusBookingState> mapEventToState(
    BusBookingEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
