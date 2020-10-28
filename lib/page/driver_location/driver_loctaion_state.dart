part of 'driver_loctaion_bloc.dart';

@immutable
abstract class DriverLocationState {}

class DriverLocationInitial extends DriverLocationState {}
class DriverLocationStateShowLocation extends DriverLocationState{
  DriverLocationStateShowLocation({this.driver, this.vehicle, this.busLocation,this.markerIcon});
  final User driver;
  final Vehicle vehicle;
  final LatLng busLocation;
  final Uint8List markerIcon;
}
class DriverLocationStateFail extends DriverLocationState{}
class DriverLocationStateLoading extends DriverLocationState{}
class DriverLocationStateDismissLoading extends DriverLocationState{}