part of 'ticket_detail_bloc.dart';

@immutable
abstract class TicketDetailEvent {}

class TickBoxesTicketDetailEvent extends TicketDetailEvent {
  TickBoxesTicketDetailEvent(this.box_1, this.pickUp, this.dropDown, this.pointUp, this.pointDown);

  final bool box_1;

  final String pickUp;
  final String dropDown;
  final Point pointUp;
  final Point pointDown;
}
