part of 'seat_number_bloc.dart';

@immutable
abstract class SeatNumberState {}

class SeatNumberInitial extends SeatNumberState {
  SeatNumberInitial(this.seatNumber);

  final int seatNumber;

}

class CallBackSeatNumberState extends SeatNumberState {
  CallBackSeatNumberState(this.seatNumber);

  final int seatNumber;

}