part of 'bus_booking_bloc.dart';

@immutable
abstract class BusBookingEvent {}


class GetDataBusBookingEvent extends BusBookingEvent{
  GetDataBusBookingEvent(this.date, this.selectedPoints);
  final DateTime date;
  final List<Point> selectedPoints;
}
class ChangeToHomeBusBookingEvent extends BusBookingEvent{}

