part of 'bus_list_bloc.dart';

@immutable
abstract class BusListEvent {}

class GetDataBusListEvent extends BusListEvent {
  GetDataBusListEvent(this.startPoint, this.endPoint, this.date, this.page);

  final String startPoint;
  final String endPoint;
  final DateTime date;
  final int page;
}

class ChangeDateBusListEvent extends BusListEvent {
  ChangeDateBusListEvent(this.date);

  final DateTime date;
}

class LoadMoreBusListEvent extends BusListEvent {}

class SortListGetDataBusListEvent extends BusListEvent{
  SortListGetDataBusListEvent(this.sortTypes);
  final List<bool> sortTypes;

}
