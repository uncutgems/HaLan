part of 'seat_map_bloc.dart';

@immutable
abstract class SeatMapEvent {}

class GetDataSeatMapEvent extends SeatMapEvent {
  GetDataSeatMapEvent(this.listSeat1, this.listSeat2);

  final List<Seat> listSeat1;
  final List<Seat> listSeat2;

}

class ClickSeatSeatMapEvent extends SeatMapEvent {
  ClickSeatSeatMapEvent(this.seat);

  final Seat seat;
}

//class GetListTicketSeatMapEvent extends SeatMapEvent{
//  GetListTicketSeatMapEvent(this.trip, this.pointUpId, this.pointDownId, this.routeEntity);
//  final Trip trip;
//  final String pointUpId;
//  final String pointDownId;
//  final RouteEntity routeEntity;
//
//}