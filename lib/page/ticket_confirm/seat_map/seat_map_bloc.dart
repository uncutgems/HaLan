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
    final SeatMapState currentState = state;

    if (event is GetDataSeatMapEvent) {
      yield GetDataSeatMapState(event.listSeat1, event.listSeat2);
    }
    if (currentState is GetDataSeatMapState) {
        if (event is ClickSeatSeatMapEvent) {
        if (event.seat.floor == 1) {
          final int index1 = currentState.seatList1
              .indexWhere((Seat mySeat) => mySeat.seatId == event.seat.seatId);
          currentState.seatList1[index1] = currentState.seatList1[index1]
              .copyWith(isPicked: !event.seat.isPicked);
        } else if (event.seat.floor == 2) {
          final int index2 = currentState.seatList2
              .indexWhere((Seat mySeat) => mySeat.seatId == event.seat.seatId);
          currentState.seatList2[index2] = currentState.seatList2[index2]
              .copyWith(isPicked: !event.seat.isPicked);
        }
        yield GetDataSeatMapState(
            currentState.seatList1, currentState.seatList2);
      }
    }
  }
}

void assignTickets(
  List<Seat> seatList,
  List<Ticket> ticketList,
  List<Point> listPoint,
  String pointUpId,
  String pointDownId,
  List<Ticket> qualifiedTickets,
) {
  for (final Seat seat in seatList) {
    final int index = seatList.indexOf(seat);
    final List<Ticket> sameSeat = <Ticket>[];
    for (final Ticket ticket in ticketList) {
      if (ticket.seat != null) {
        if (ticket.seat.seatId == seat.seatId) {
          sameSeat.add(ticket);
          if (sameSeat.isNotEmpty &&
              sameSeat.any((Ticket ticket) =>
                  checkTicket(ticket, listPoint, pointUpId, pointDownId))) {
            if (checkTicket(ticket, listPoint, pointUpId, pointDownId)) {
              qualifiedTickets.add(ticket);
            }
            seatList[index] = seat.copyWith(
                ticketStatus: sameSeat
                    .firstWhere((Ticket ticket) =>
                        checkTicket(ticket, listPoint, pointUpId, pointDownId))
                    .ticketStatus);
          } else
            seatList[index] = seat.copyWith(ticketStatus: TicketStatus.empty);
        }
      }
    }
  }
}

bool checkTicket(Ticket ticket, List<Point> listPoint, String routePointUp,
    String routePointDown) {
  final int ticketUpIndex =
      listPoint.indexWhere((Point point) => point.id == ticket.pointUp.id);
  final int ticketDownIndex =
      listPoint.indexWhere((Point point) => point.id == ticket.pointDown.id);
  final int routePointUpIndex =
      listPoint.indexWhere((Point point) => point.id == routePointUp);
  final int routePointDownIndex =
      listPoint.indexWhere((Point point) => point.id == routePointDown);

  if (((ticketDownIndex - ticketUpIndex) >=
          (routePointDownIndex - routePointUpIndex)) &&
      (ticketUpIndex <= routePointUpIndex) &&
      (routePointUpIndex <= routePointDownIndex) &&
      (routePointDownIndex <= ticketDownIndex)) {
    return true;
  } else if ((routePointUpIndex < ticketUpIndex) &&
      (ticketUpIndex < routePointDownIndex)) {
    return true;
  } else if ((routePointUpIndex < ticketDownIndex) &&
      (ticketDownIndex < routePointDownIndex)) {
    return true;
  } else
    return false;
}
