part of 'bus_list_bloc.dart';

@immutable
abstract class BusListState {}

class BusListInitial extends BusListState {}

class SuccessGetDataBusListState extends BusListState {
  SuccessGetDataBusListState(
      {@required this.listTrip,
      @required this.page,
      this.dateSelected,
      this.startPoint,
      this.endPoint,
      @required this.allowLoadMore,
      this.sortSelections,
      this.size = Size.zero});

  final String startPoint;
  final String endPoint;
  final List<Trip> listTrip;
  final int page;
  final DateTime dateSelected;
  final bool allowLoadMore;
  final List<SortSelection> sortSelections;
  final Size size;
}

class FailGetDataBusListState extends BusListState {
  FailGetDataBusListState(this.error);

  final String error;
}

class ShowLoadingGetDataBusListState extends BusListState {}

class TurnOffLoadingGetDataBusListState extends BusListState {}

class AllowLoadMoreGetDataBusListState extends BusListState {
  AllowLoadMoreGetDataBusListState(this.allowLoad);

  final bool allowLoad;
}
