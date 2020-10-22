part of 'ticket_detail_bloc.dart';

@immutable
abstract class TicketDetailState {}

class TicketDetailInitial extends TicketDetailState {}

class TicketDetailChangeCheckBoxState extends TicketDetailState {
  TicketDetailChangeCheckBoxState(this.firstBoxState, this.pickUp, this.dropDown, this.pointUp, this.pointDown);
  final bool firstBoxState;
  final String pickUp;
  final String dropDown;
  final Point pointUp;
  final Point pointDown;
}
