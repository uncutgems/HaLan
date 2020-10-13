part of 'trip_filter_bloc.dart';

@immutable
abstract class TripFilterEvent {}

class SortTripFilterEvent extends TripFilterEvent {
  SortTripFilterEvent(this.key);

  final Key key;
}
