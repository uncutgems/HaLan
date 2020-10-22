part of 'payment_qr_bloc.dart';

@immutable
abstract class PaymentQrEvent {}

class GetDataStringPaymentQrEvent  extends PaymentQrEvent{
  GetDataStringPaymentQrEvent(this.listTicket);

  final List<Ticket> listTicket;
}
