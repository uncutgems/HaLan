import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ticket_payment_event.dart';

part 'ticket_payment_state.dart';

class TicketPaymentBloc extends Bloc<TicketPaymentEvent, TicketPaymentState> {
  TicketPaymentBloc() : super(TicketPaymentInitial(0, 0));

  @override
  Stream<TicketPaymentState> mapEventToState(
    TicketPaymentEvent event,
  ) async* {
    if (event is ChangeSeatNumberTicketPaymentEvent) {
      final double totalMoney = event.seatNumber * event.tripPrice;

      yield TicketPaymentInitial(event.seatNumber, totalMoney);
    }
  }
}
