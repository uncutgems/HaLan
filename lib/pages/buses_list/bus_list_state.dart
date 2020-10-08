part of 'bus_list_bloc.dart';

@immutable
abstract class BusListState {}

class BusListInitial extends BusListState {}

class SuccessGetDataBusListState extends BusListState{
  SuccessGetDataBusListState(this.listTrip);
  final List<Trip> listTrip;

}

class FailGetDataBusListState extends BusListState {
  FailGetDataBusListState(this.error);
  final String error;

}