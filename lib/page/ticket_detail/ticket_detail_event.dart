part of 'ticket_detail_bloc.dart';

@immutable
abstract class TicketDetailEvent {}

class TickBoxesTicketDetailEvent extends TicketDetailEvent {
  TickBoxesTicketDetailEvent(this.box_1, this.box_2);

  final bool box_1;
  final bool box_2;
}
