import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/ticket_repository.dart';
import 'package:meta/meta.dart';

part 'history_ticket_detail_event.dart';

part 'history_ticket_detail_state.dart';

class HistoryTicketDetailBloc
    extends Bloc<HistoryTicketDetailEvent, HistoryTicketDetailState> {
  HistoryTicketDetailBloc() : super(HistoryTicketDetailInitial());

  final TicketRepository _ticketRepository = TicketRepository();

  @override
  Stream<HistoryTicketDetailState> mapEventToState(
    HistoryTicketDetailEvent event,
  ) async* {
    if (event is GetDataHistoryTicketDetailEvent) {
      try {
        int totalMoney = 0;

        final List<Ticket> listTicket =
            await _ticketRepository.getTicketsByCode(event.ticketCode);
        for (int i = 0; i < listTicket.length; i++) {
          totalMoney += listTicket[i].agencyPrice.toInt();
        }

        yield SuccessGetDataTicketDetailState(listTicket, totalMoney);
      } on APIException catch (e) {
        yield FailGetDataTicketDetailState(e.message());
      }
    }
  }
}
