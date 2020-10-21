part of 'history_ticket_detail_bloc.dart';

@immutable
abstract class HistoryTicketDetailState {}

class HistoryTicketDetailInitial extends HistoryTicketDetailState {}

class SuccessGetDataTicketDetailState extends HistoryTicketDetailState {
  SuccessGetDataTicketDetailState(this.listTicket, this.totalMoney);

  final List<Ticket> listTicket;
  final int totalMoney;
}

class FailGetDataTicketDetailState extends HistoryTicketDetailState{
  FailGetDataTicketDetailState(this.error);

  final String error;

}