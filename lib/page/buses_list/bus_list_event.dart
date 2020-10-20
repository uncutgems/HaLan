part of 'bus_list_bloc.dart';

@immutable
abstract class BusListEvent {}

class GetDataBusListEvent extends BusListEvent {
  GetDataBusListEvent(
      {this.startTime,
      this.endTime,
      this.startPoint,
      this.endPoint,
      this.date,
      this.page});

  final String startPoint;
  final String endPoint;
  final DateTime date;
  final int page;
  final int startTime;
  final int endTime;
}

class ChangeDateBusListEvent extends BusListEvent {
  ChangeDateBusListEvent(this.date);

  final DateTime date;
}

class LoadMoreBusListEvent extends BusListEvent {}

class SortListGetDataBusListEvent extends BusListEvent {
  SortListGetDataBusListEvent(this.sortTypes);

  final List<bool> sortTypes;
}

class SortTimePeriodBusListEvent extends BusListEvent {
  SortTimePeriodBusListEvent(this.startTime, this.endTime);

  final int startTime;
  final int endTime;
}

class ChangingSizeBusListEvent extends BusListEvent {
  ChangingSizeBusListEvent(this.size);

  final Size size;
}
