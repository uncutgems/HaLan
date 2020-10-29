import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/ticket_repository.dart';
import 'package:meta/meta.dart';

part 'ticket_detail_event.dart';

part 'ticket_detail_state.dart';

class TicketDetailBloc extends Bloc<TicketDetailEvent, TicketDetailState> {
  TicketDetailBloc() : super(TicketDetailInitial());
  TicketRepository repository = TicketRepository();
  @override
  Stream<TicketDetailState> mapEventToState(
    TicketDetailEvent event,
  ) async* {
    if (event is TickBoxesTicketDetailEvent) {
      yield TicketDetailChangeCheckBoxState(event.box_1,event.pickUp,event.dropDown,event.pointUp,event.pointDown,event.totalMoney);
    }
    else if (event is TicketDetailClickButtonEvent){
      final List<TicketOption> informationBySeats= <TicketOption>[];
      for (final Seat seat in event.seatSelected) {
        final TicketOption ticketOption =
        TicketOption(
          seatId: seat.seatId,
          fullName:event.fullName,
          phoneNumber: event.phoneNumber,
          ticketPrice: event.totalPrice,
          isAdult: true,
          extraPrice: seat.extraPrice,
          agencyPrice: event.totalPrice,
          isTransshipment: false,
          pointUp: event.pointUp,
          pointDown: event.pointDown,
          promotionCode: '',
          note: event.note,
          email: event.email,
        );
        print('=========================================== ${ticketOption.ticketStatus}');
        print('=========================================== ${ticketOption.pointDown.name}');
        print('=========================================== ${ticketOption.pointUp.name}');
        print('=========================================== ${ticketOption.pointUp.pointType}');
        print('=========================================== ${ticketOption.originalPrice}');
        informationBySeats.add(ticketOption);
      }
      yield TicketDetailLoadingState();
      try {
        final List<Ticket> tickets = await repository.bookTicket(event.trip.tripId, informationBySeats);
        yield TicketDetailDismissLoadingState();
        yield TicketDetailNextPageState(tickets.first.ticketCode);
      }
      on APIException catch(e){
        yield TicketDetailDismissLoadingState();
        yield TicketDetailFailState(e.message());
      }
    }
  }
}
