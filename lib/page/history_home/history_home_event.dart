part of 'history_home_bloc.dart';

@immutable
abstract class HistoryHomeEvent {}

class GetDataHistoryHomeEvent extends HistoryHomeEvent {
  GetDataHistoryHomeEvent(this.page);

  final int page;
}

class LoadMoreHistoryHomeEvent extends HistoryHomeEvent {}
