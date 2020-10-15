part of 'ticket_payment_bloc.dart';

@immutable
abstract class TicketPaymentState {}

class TicketPaymentInitial extends TicketPaymentState {
  TicketPaymentInitial(this.listSeat, this.totalPrice);

  final List<Seat> listSeat;
  final int totalPrice;
}
