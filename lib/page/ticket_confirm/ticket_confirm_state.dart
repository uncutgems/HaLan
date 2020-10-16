part of 'ticket_confirm_bloc.dart';

@immutable
abstract class TicketConfirmState {}

class TicketConfirmInitial extends TicketConfirmState {}

class SuccessGetDataTicketConfirmState extends TicketConfirmState {
  SuccessGetDataTicketConfirmState(this.routeEntity, this.tripPrice, this.listSeat1, this.listSeat2);

  final RouteEntity routeEntity;
  final int tripPrice;
  final List<Seat> listSeat1;
  final List<Seat> listSeat2;
}

class FailGetDataTicketConfirmState extends TicketConfirmState {
  FailGetDataTicketConfirmState(this.error);

  final String error;

}

class TurnOnLoadingTicketConfirmState extends TicketConfirmState {}
class TurnOffLoadingTicketConfirmState extends TicketConfirmState {}