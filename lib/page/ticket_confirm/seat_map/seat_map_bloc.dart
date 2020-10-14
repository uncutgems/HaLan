import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/model/enum.dart';
import 'package:meta/meta.dart';

part 'seat_map_event.dart';

part 'seat_map_state.dart';

class SeatMapBloc extends Bloc<SeatMapEvent, SeatMapState> {
  SeatMapBloc() : super(SeatMapInitial());

  @override
  Stream<SeatMapState> mapEventToState(
    SeatMapEvent event,
  ) async* {
    final List<Seat> defaultList1 = <Seat>[];
    final List<Seat> defaultList2 = <Seat>[];
    if (event is GetDataSeatMapEvent) {
      for (int i = 1; i <= event.trip.seatMap.numberOfRows; i++) {
        for (int j = 1; j <= event.trip.seatMap.numberOfColumns; j++) {
          defaultList1.add(Seat(
            row: i,
            column: j,
            seatType: SeatType.empty,
            ticketStatus: TicketStatus.empty,
          ));
          for (final Seat seat in event.trip.seatMap.seatList) {
            final int index = defaultList1.indexWhere((Seat emptySeat) =>
            seat.row == emptySeat.row && seat.column == emptySeat.column);
            if (index != -1 && seat.floor == 1) {
              defaultList1[index] =
                  seat.copyWith(ticketStatus: TicketStatus.empty);
            }
          }
          print('vào đây?2');

          defaultList2.add(Seat(
            row: i,
            column: j,
            seatType: SeatType.empty,
            ticketStatus: TicketStatus.empty,
          ));
          for (final Seat seat in event.trip.seatMap.seatList) {
            final int index = defaultList2.indexWhere((Seat emptySeat) =>
            seat.row == emptySeat.row && seat.column == emptySeat.column);
            if (index != -1 && seat.floor == 2) {
              defaultList2[index] =
                  seat.copyWith(ticketStatus: TicketStatus.empty);
            }
          }
          print('vào đây?3');

        }
      }

      yield GetDataSeatMapState(defaultList1, defaultList2);
//      _mapGetDataSeatMapEventToState(event, defaultList1, defaultList2);
    }
  }

}
