part of 'ticket_payment_bloc.dart';

@immutable
abstract class TicketPaymentEvent {}

class ChangeSeatNumberTicketPaymentEvent extends TicketPaymentEvent{
  ChangeSeatNumberTicketPaymentEvent(this.seatNumber, this.tripPrice);
  final int seatNumber;
  final double tripPrice;

}

