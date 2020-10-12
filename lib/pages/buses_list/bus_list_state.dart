part of 'bus_list_bloc.dart';

@immutable
abstract class BusListState {}

class BusListInitial extends BusListState {}

class SuccessGetDataBusListState extends BusListState{
  SuccessGetDataBusListState(this.listTrip, this.page, this.dateSelected, this.startPoint, this.endPoint, this.allowLoadMore, this.sortSelections);
  final String startPoint;
  final String endPoint;
  final List<Trip> listTrip;
  final int page;
  final DateTime dateSelected;
  final bool allowLoadMore;
  final List<SortSelection> sortSelections;

}

class FailGetDataBusListState extends BusListState {
  FailGetDataBusListState(this.error);
  final String error;

}

class ShowLoadingGetDataBusListState extends BusListState{}
class TurnOffLoadingGetDataBusListState extends BusListState{}
class AllowLoadMoreGetDataBusListState extends BusListState{
  AllowLoadMoreGetDataBusListState(this.allowLoad);
  final bool allowLoad;

}

