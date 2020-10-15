part of 'bus_booking_bloc.dart';

@immutable
abstract class BusBookingState {}

class BusBookingInitial extends BusBookingState {}

class DisplayDataBusBookingState extends BusBookingState {}

class FailBusBookingState extends BusBookingState {}

class LoadingDataBusBookingState extends BusBookingState {}

class DismissLoadingBusBookingState extends BusBookingState {}
