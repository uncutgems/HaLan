class ChoosableSeat {
  static const int allowed = 1;
  static const int notAllowed = 0;
}

class TicketStatus {
  static const int invalid = -2;
  static const int canceled = 0;
  static const int empty = 1;
  static const int booked = 2;
  static const int bought = 3;
  static const int onTheTrip = 4;
  static const int completed = 5;
  static const int overTime = 6;
  static const int bookedAdmin = 7;
}

class SeatType {
  static const int empty = -1;
  static const int waiting = 0;
  static const int door = 1;
  static const int driverSeat = 2;
  static const int normalSeat = 3;
  static const int bedSeat = 4;
  static const int wc = 5;
  static const int astSeat = 5;
}