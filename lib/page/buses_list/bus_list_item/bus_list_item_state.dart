part of 'bus_list_item_bloc.dart';

@immutable
abstract class BusListItemState {}

class BusListItemInitial extends BusListItemState {
  BusListItemInitial(this.size);

  final Size size;
}
