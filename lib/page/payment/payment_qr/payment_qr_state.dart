part of 'payment_qr_bloc.dart';

@immutable
abstract class PaymentQrState {}

class PaymentQrInitial extends PaymentQrState {}

class SuccessGetDataPaymentQrState extends PaymentQrState {
  SuccessGetDataPaymentQrState(this.dataString);

  final String dataString;
}

class FailGetDataPaymentQrState extends PaymentQrState {
  FailGetDataPaymentQrState(this.error);

  final String error;
}
