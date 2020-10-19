part of 'home_otp_bloc.dart';

@immutable
abstract class HomeOtpEvent {}

class ClickSendAgainHomeOtpEvent extends HomeOtpEvent {
  ClickSendAgainHomeOtpEvent(this.phoneNumber);

  final String phoneNumber;
}

class ClickLogInButtonHomeOtpEvent extends HomeOtpEvent {
  ClickLogInButtonHomeOtpEvent(this.phoneNumber, this.otpCode);

  final String phoneNumber;
  final String otpCode;
}
