import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/qr_repository.dart';
import 'package:meta/meta.dart';

part 'payment_qr_event.dart';

part 'payment_qr_state.dart';

class PaymentQrBloc extends Bloc<PaymentQrEvent, PaymentQrState> {
  PaymentQrBloc() : super(PaymentQrInitial());

  final QRRepository _qrRepository = QRRepository();

  @override
  Stream<PaymentQrState> mapEventToState(
    PaymentQrEvent event,
  ) async* {
    if (event is GetDataStringPaymentQrEvent) {
      try {
        yield SuccessGetDataPaymentQrState('');
        String ticketIds = event.listTicket.first.ticketId;
        if (event.listTicket.length > 1) {
          for (int i = 1; i < event.listTicket.length; i++) {
            ticketIds = ticketIds + '-' + event.listTicket[i].ticketId;
          }
        } else
          ticketIds = event.listTicket.first.ticketId;
        final String dataString = await _qrRepository.getQRCode(ticketIds);
        yield SuccessGetDataPaymentQrState(dataString);
      } on APIException catch (e) {
        yield FailGetDataPaymentQrState(e.message());
      }
    }
  }
}
