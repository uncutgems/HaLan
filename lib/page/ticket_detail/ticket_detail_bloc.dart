import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/model/entity.dart';
import 'package:meta/meta.dart';

part 'ticket_detail_event.dart';

part 'ticket_detail_state.dart';

class TicketDetailBloc extends Bloc<TicketDetailEvent, TicketDetailState> {
  TicketDetailBloc() : super(TicketDetailInitial());

  @override
  Stream<TicketDetailState> mapEventToState(
    TicketDetailEvent event,
  ) async* {
    if (event is TickBoxesTicketDetailEvent) {
      yield TicketDetailChangeCheckBoxState(event.box_1,event.pickUp,event.dropDown,event.pointUp,event.pointDown);
    }
  }
}
