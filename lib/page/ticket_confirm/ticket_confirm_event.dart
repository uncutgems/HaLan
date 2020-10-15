part of 'ticket_confirm_bloc.dart';

@immutable
abstract class TicketConfirmEvent {}

class GetDataTicketConfirmEvent extends TicketConfirmEvent {
  GetDataTicketConfirmEvent(this.trip, this.pointUpId, this.pointDownId);

  final Trip trip;
  final String pointUpId;
  final String pointDownId;
}

class GetListTicketTicketConfirmEvent extends TicketConfirmEvent {
  GetListTicketTicketConfirmEvent(
      this.trip, this.pointUpId, this.pointDownId);

  final Trip trip;
  final String pointUpId;
  final String pointDownId;
//  final RouteEntity routeEntity;
}
