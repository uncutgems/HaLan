import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/model/enum.dart';
import 'package:meta/meta.dart';

part 'ticket_payment_event.dart';

part 'ticket_payment_state.dart';

class TicketPaymentBloc extends Bloc<TicketPaymentEvent, TicketPaymentState> {
  TicketPaymentBloc() : super(TicketPaymentInitial(const <Seat>[], 0));

  @override
  Stream<TicketPaymentState> mapEventToState(
    TicketPaymentEvent event,
  ) async* {
    final List<Seat> qualifiedSeats = <Seat>[];
    if (event is ChangeSeatNumberTicketPaymentEvent) {
      final List<Seat> chosenSeat = <Seat>[];
      qualifiedSeats.addAll(event.totalSeat);
      qualifiedSeats.removeWhere((Seat seat) =>
          seat.ticketStatus != TicketStatus.empty ||
          (seat.seatType != SeatType.normalSeat &&
              seat.seatType != SeatType.bedSeat));

      for (int i = 0; i < event.seatNumber; i++) {
        chosenSeat.add(qualifiedSeats[i]);
      }
      int totalMoney = event.tripPrice * chosenSeat.length;

      for (int i = 0; i < chosenSeat.length; i++) {
        print(chosenSeat[i].seatId);
        if (chosenSeat[i].extraPrice != null) {
          totalMoney += chosenSeat[i].extraPrice.toInt();
        }
      }

      yield TicketPaymentInitial(chosenSeat, totalMoney);
    }

    if (event is ChooseSeatTicketPaymentEvent) {
      int totalMoney = event.tripPrice * event.listSeat.length;

      for (int i = 0; i < event.listSeat.length; i++) {
        totalMoney += event.listSeat[i].extraPrice.toInt();
      }

      yield TicketPaymentInitial(event.listSeat, totalMoney);
    }
  }
}
