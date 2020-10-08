part of 'bus_list_bloc.dart';

@immutable
abstract class BusListEvent {}

class GetDataBusListEvent extends BusListEvent {
  GetDataBusListEvent(this.startPoint, this.endPoint, this.date);

  final String startPoint;
  final String endPoint;
  final int date;
}
