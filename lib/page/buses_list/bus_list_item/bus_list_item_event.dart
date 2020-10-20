part of 'bus_list_item_bloc.dart';

@immutable
abstract class BusListItemEvent {}

class ChangingSizeBusListItemEvent extends BusListItemEvent {
  ChangingSizeBusListItemEvent(this.size);

  final Size size;
}
