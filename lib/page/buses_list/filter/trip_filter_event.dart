part of 'trip_filter_bloc.dart';

@immutable
abstract class TripFilterEvent {}

class SortTripByTimeFilterEvent extends TripFilterEvent {
  SortTripByTimeFilterEvent(this.timeSort);
  final bool timeSort;

}
class SortTripByPriceFilterEvent extends TripFilterEvent {
  SortTripByPriceFilterEvent(this.priceSort);
  final bool priceSort;

}

class SortByTimePeriodFilterEvent extends TripFilterEvent{
  SortByTimePeriodFilterEvent(this.timePeriod);

  final List<int> timePeriod;

}
