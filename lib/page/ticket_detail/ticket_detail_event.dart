part of 'ticket_detail_bloc.dart';

@immutable
abstract class TicketDetailEvent {}

class TickBoxesTicketDetailEvent extends TicketDetailEvent {
  TickBoxesTicketDetailEvent(this.box_1, this.pickUp, this.dropDown, this.pointUp, this.pointDown, this.totalMoney);

  final bool box_1;

  final String pickUp;
  final String dropDown;
  final Point pointUp;
  final Point pointDown;
  final int totalMoney;
}

class TicketDetailClickButtonEvent extends TicketDetailEvent{
  TicketDetailClickButtonEvent({this.trip, this.seatSelected, this.totalPrice, this.fullName, this.phoneNumber, this.pointUp, this.pointDown, this.note, this.email});
  final Trip trip;
  final List<Seat> seatSelected;
  final double totalPrice;
  final String fullName;
  final String phoneNumber;
  final Point pointUp;
  final Point pointDown;
  final String note;
  final String email;

}