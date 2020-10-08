part of 'buses_list_filter_bloc.dart';

@immutable
abstract class BusesListFilterState {}

class BusesListFilterInitial extends BusesListFilterState {
  BusesListFilterInitial(this.time);

  final int time;

}
