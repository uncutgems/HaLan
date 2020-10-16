import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/model/enum.dart';
import 'package:halan/repository/route_repository.dart';
import 'package:halan/repository/ticket_repository.dart';
import 'package:meta/meta.dart';

part 'ticket_confirm_event.dart';

part 'ticket_confirm_state.dart';

class TicketConfirmBloc extends Bloc<TicketConfirmEvent, TicketConfirmState> {
  TicketConfirmBloc()
      : super(SuccessGetDataTicketConfirmState(
            RouteEntity(), 0, const <Seat>[], const <Seat>[]));

  final RouteRepository _routeRepository = RouteRepository();
  final TicketRepository _ticketRepository = TicketRepository();

  @override
  Stream<TicketConfirmState> mapEventToState(
    TicketConfirmEvent event,
  ) async* {
    final TicketConfirmState currentState = state;
    final List<Seat> defaultList1 = <Seat>[];
    final List<Seat> defaultList2 = <Seat>[];
    if (event is GetDataTicketConfirmEvent) {
      try {
        final RouteEntity routeEntity =
            await _routeRepository.showRoute(event.trip.route.id);
        final List<Point> listPoint = routeEntity.listPoint;
        final int routePointDownIndex = listPoint
            .indexWhere((Point point) => point.id == event.pointDownId);
        final int tripPrice =
            event.trip.pointUp.listPrice[routePointDownIndex].toInt();
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
          }
        }
        yield SuccessGetDataTicketConfirmState(
            routeEntity, tripPrice, defaultList1, defaultList2);
      } on APIException catch (e) {
        yield FailGetDataTicketConfirmState(e.message());
      }
    }
    if (currentState is SuccessGetDataTicketConfirmState) {
      if (event is GetListTicketTicketConfirmEvent) {
        final List<Ticket> defaultTicket = <Ticket>[];
        final List<Ticket> qualifiedTickets = <Ticket>[];

        try {
          yield TurnOnLoadingTicketConfirmState();
          final List<Ticket> listTicket =
              await _ticketRepository.getListTicketForUser(
                  event.trip.tripId, event.pointUpId, event.pointDownId);
          defaultTicket.addAll(listTicket);
          defaultTicket.removeWhere((Ticket ticket) =>
              ticket.ticketStatus == TicketStatus.canceled ||
              ticket.ticketStatus == TicketStatus.overTime);

          assignTickets(
              currentState.listSeat1,
              defaultTicket,
              currentState.routeEntity.listPoint,
              event.pointUpId,
              event.pointDownId,
              qualifiedTickets);
          assignTickets(
              currentState.listSeat2,
              defaultTicket,
              currentState.routeEntity.listPoint,
              event.pointUpId,
              event.pointDownId,
              qualifiedTickets);
          yield TurnOffLoadingTicketConfirmState();
          yield SuccessGetDataTicketConfirmState(
              currentState.routeEntity,
              currentState.tripPrice,
              currentState.listSeat1,
              currentState.listSeat2);
        } on APIException catch (e) {
          yield TurnOffLoadingTicketConfirmState();
          yield FailGetDataTicketConfirmState(e.message());
        }
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
