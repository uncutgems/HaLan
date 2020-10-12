part of 'trip_filter_bloc.dart';

@immutable
abstract class TripFilterState {}

class TripFilterInitial extends TripFilterState {
  TripFilterInitial(this.selectedButton);

  final Key selectedButton;
}

class CallBackTripFilterState extends TripFilterState {
  CallBackTripFilterState(this.key);
  final Key key;

}
