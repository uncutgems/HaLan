part of 'ticket_detail_bloc.dart';

@immutable
abstract class TicketDetailState {}

class TicketDetailInitial extends TicketDetailState {}

class TicketDetailChangeCheckBoxState extends TicketDetailState {
  TicketDetailChangeCheckBoxState(this.firstBoxState, this.pickUp, this.dropDown, this.pointUp, this.pointDown, this.totalMoney);
  final bool firstBoxState;
  final String pickUp;
  final String dropDown;
  final Point pointUp;
  final Point pointDown;
  final int totalMoney;
}
class TicketDetailLoadingState extends TicketDetailState{}
class TicketDetailFailState extends TicketDetailState{
  TicketDetailFailState(this.error);
  final String error;
}
class TicketDetailDismissLoadingState extends TicketDetailState{}
class TicketDetailNextPageState extends TicketDetailState{
  TicketDetailNextPageState(this.ticketCode);
  final String ticketCode;

}