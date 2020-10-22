part of 'bus_booking_bloc.dart';

@immutable
abstract class BusBookingState {}

class BusBookingInitial extends BusBookingState {}

class DisplayDataBusBookingState extends BusBookingState {
  DisplayDataBusBookingState(this.date, this.selectedPoint);
  final DateTime date;
  final List<Point> selectedPoint;
}
class ChangeToHomeBusBookingState extends BusBookingState{}



class LoadingDataBusBookingState extends BusBookingState {}
class DismissLoadingBusBookingState extends BusBookingState {}
class LoadingBusBookingState extends BusBookingState {}