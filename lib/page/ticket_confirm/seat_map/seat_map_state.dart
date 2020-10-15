part of 'seat_map_bloc.dart';

@immutable
abstract class SeatMapState {}

class SeatMapInitial extends SeatMapState {}


class GetDataSeatMapState extends SeatMapState {
  GetDataSeatMapState(
      this.seatList1,
      this.seatList2,
//      this.ticketList,
//      this.tripPrice,
      );

  final List<Seat> seatList1;
  final List<Seat> seatList2;
//  final List<Ticket> ticketList;
//  final double tripPrice;

}
