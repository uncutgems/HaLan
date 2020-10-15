part of 'ticket_payment_bloc.dart';

@immutable
abstract class TicketPaymentState {}

class TicketPaymentInitial extends TicketPaymentState {
  TicketPaymentInitial(this.seatNumber, this.totalPrice);

  final int seatNumber;
  final double totalPrice;
}
