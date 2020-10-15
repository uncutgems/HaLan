part of 'trip_filter_bloc.dart';

@immutable
abstract class TripFilterState {}

class TripFilterInitial extends TripFilterState {
  TripFilterInitial(this.timeSort, this.priceSort);
  final bool timeSort;
  final bool priceSort;

}

class CallBackTripFilterState extends TripFilterState {
  CallBackTripFilterState(this.timeSort, this.priceSort);

  final bool timeSort;
  final bool priceSort;


}
