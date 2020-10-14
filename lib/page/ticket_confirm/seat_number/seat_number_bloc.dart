import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'seat_number_event.dart';
part 'seat_number_state.dart';

class SeatNumberBloc extends Bloc<SeatNumberEvent, SeatNumberState> {
  SeatNumberBloc() : super(SeatNumberInitial(1));

  @override
  Stream<SeatNumberState> mapEventToState(
    SeatNumberEvent event,
  ) async* {
    if (event is AddSeatNumberEvent) {
      yield CallBackSeatNumberState(event.seatNumber + 1);
      yield SeatNumberInitial(event.seatNumber + 1);
    } else if (event is MinusSeatNumberEvent) {
      if (event.seatNumber >1) {
        yield CallBackSeatNumberState(event.seatNumber -1 );
        yield SeatNumberInitial(event.seatNumber -1);
      }
    } else if (event is GetDataSeatNumberEvent) {
      yield CallBackSeatNumberState(1);
      yield SeatNumberInitial(1);
    }
  }
}
