part of 'ticket_detail_bloc.dart';

@immutable
abstract class TicketDetailState {}

class TicketDetailInitial extends TicketDetailState {}

class ChangeCheckBoxStatusTicketDetailState extends TicketDetailState {
  ChangeCheckBoxStatusTicketDetailState(this.firstBoxState, this.secondBoxState);

  final bool firstBoxState;
  final bool secondBoxState;
}
