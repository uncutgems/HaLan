import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'history_ticket_detail_event.dart';
part 'history_ticket_detail_state.dart';

class HistoryTicketDetailBloc extends Bloc<HistoryTicketDetailEvent, HistoryTicketDetailState> {
  HistoryTicketDetailBloc() : super(HistoryTicketDetailInitial());

  @override
  Stream<HistoryTicketDetailState> mapEventToState(
    HistoryTicketDetailEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
