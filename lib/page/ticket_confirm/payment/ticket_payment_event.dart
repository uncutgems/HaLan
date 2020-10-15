part of 'ticket_payment_bloc.dart';

@immutable
abstract class TicketPaymentEvent {}

class ChangeSeatNumberTicketPaymentEvent extends TicketPaymentEvent {
  ChangeSeatNumberTicketPaymentEvent(this.seatNumber, this.tripPrice, this.totalSeat);

  final int seatNumber;
  final int tripPrice;
  final List<Seat> totalSeat;
}

class ChooseSeatTicketPaymentEvent extends TicketPaymentEvent {
  ChooseSeatTicketPaymentEvent(this.listSeat, this.tripPrice);

  final List<Seat> listSeat;
  final int tripPrice;
}
