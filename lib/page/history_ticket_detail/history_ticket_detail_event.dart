part of 'history_ticket_detail_bloc.dart';

@immutable
abstract class HistoryTicketDetailEvent {}

class GetDataHistoryTicketDetailEvent extends HistoryTicketDetailEvent{
  GetDataHistoryTicketDetailEvent(this.ticketCode);

  final String ticketCode;
}
