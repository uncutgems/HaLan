part of 'history_home_bloc.dart';

@immutable
abstract class HistoryHomeState {}

class HistoryHomeInitial extends HistoryHomeState {}

class SuccessGetDataHistoryHomeState extends HistoryHomeState {
  SuccessGetDataHistoryHomeState(this.listTicket, this.page);

  final List<Ticket> listTicket;
  final int page;
}

class FailGetDataHistoryHomeState extends HistoryHomeState {
  FailGetDataHistoryHomeState(this.error);

  final String error;
}
