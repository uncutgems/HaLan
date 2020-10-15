part of 'seat_map_bloc.dart';

@immutable
abstract class SeatMapEvent {}

class GetDataSeatMapEvent extends SeatMapEvent {
  GetDataSeatMapEvent(this.trip, this.ticketList);

  final Trip trip;
  final List<Ticket> ticketList;
}

class ClickSeatSeatMapEvent extends SeatMapEvent {
  ClickSeatSeatMapEvent(this.seat);

  final Seat seat;
}