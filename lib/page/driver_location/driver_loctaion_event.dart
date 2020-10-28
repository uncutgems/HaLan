part of 'driver_loctaion_bloc.dart';

@immutable
abstract class DriverLocationEvent {}
class DriverLocationEventGetLocation extends DriverLocationEvent{
  DriverLocationEventGetLocation(this.trip);

  final Trip trip;

}
class DriverLocationEventUpdateLocation extends DriverLocationEvent{
  DriverLocationEventUpdateLocation({this.driver, this.vehicle, this.busLocation});
  final User driver;
  final Vehicle vehicle;
  final LatLng busLocation;

}