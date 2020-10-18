part of 'seat_number_bloc.dart';

@immutable
abstract class SeatNumberEvent {}

class AddSeatNumberEvent extends SeatNumberEvent {
  AddSeatNumberEvent(this.seatNumber);

  final int seatNumber;
}

class MinusSeatNumberEvent extends SeatNumberEvent {
  MinusSeatNumberEvent(this.seatNumber);

  final int seatNumber;
}

class GetDataSeatNumberEvent extends SeatNumberEvent {}
