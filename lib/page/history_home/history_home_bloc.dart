import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/ticket_repository.dart';
import 'package:meta/meta.dart';

part 'history_home_event.dart';

part 'history_home_state.dart';

class HistoryHomeBloc extends Bloc<HistoryHomeEvent, HistoryHomeState> {
  HistoryHomeBloc()
      : super(SuccessGetDataHistoryHomeState(const <Ticket>[], 0));

  final TicketRepository _ticketRepository = TicketRepository();

  @override
  Stream<HistoryHomeState> mapEventToState(
    HistoryHomeEvent event,
  ) async* {
    final HistoryHomeState currentState = state;
    if (event is GetDataHistoryHomeEvent) {
      yield* _mapGetDataHistoryHomeEventToState(<Ticket>[], 0);
    }
    if (currentState is SuccessGetDataHistoryHomeState) {
      if (event is LoadMoreHistoryHomeEvent) {
        yield* _mapGetDataHistoryHomeEventToState(
            currentState.listTicket, currentState.page + 1);
      }
    }
  }

  Stream<HistoryHomeState> _mapGetDataHistoryHomeEventToState(
      List<Ticket> listTicketOriginal, int page) async* {
    try {
      yield SuccessGetDataHistoryHomeState(listTicketOriginal, -1);
      final List<Ticket> newListTicket = <Ticket>[];
      newListTicket.addAll(listTicketOriginal);
      newListTicket.addAll(await _ticketRepository.getListTicketHistory(page));
      yield SuccessGetDataHistoryHomeState(newListTicket, page + 1);
    } on APIException catch (e) {
      if (e.aVResponse.code == 401) {
        yield TokenExpiredHomeState();
      } else
        yield FailGetDataHistoryHomeState(e.message());
    }
  }
}
