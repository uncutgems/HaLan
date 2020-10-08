part of 'buses_list_filter_bloc.dart';

@immutable
abstract class BusesListFilterEvent {}
class BusesListFilterEventClickTime extends BusesListFilterEvent{
  BusesListFilterEventClickTime(this.time);
  final int time;
}