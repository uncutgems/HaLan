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

class PlatformType {
  static const int webAdmin = 1;
  static const int online = 2;
  static const int iOS = 3;
  static const int android = 4;
  static const int agency = 5;
}

class TransportType{
  static const int station =0;
  static const int home =1;
  static const int road=2;
  static const int transshipment=3;
}

class NotificationType {
  static const int createTicketSuccess = 100;
  static const int vehicleComing = 101;
  static const int comingGetOffPointSoon = 102;
  static const int onTheTrip = 104;
  static const int sendThanksToGuest = 105;
  static const int assistantPickUp = 212;
  static const int createTicketFailed = 1001;
  static const int cancelTicketSuccess = 1002;
  static const int paymentSuccessfully = 6;
  static const int paymentFail = 7;
  static const int systemNotification = 1;
  static const int newSchedule = 200;
  static const int cancelTicket = 304;
}