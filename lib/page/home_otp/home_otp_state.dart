part of 'home_otp_bloc.dart';

@immutable
abstract class HomeOtpState {}

class HomeOtpInitial extends HomeOtpState {}


class ReloadPageHomeOtpState extends HomeOtpState{}

class LogInSuccessfullyHomeOtpState extends HomeOtpState{}

class LoadingHomeOtpState extends HomeOtpState{}

class DismissLoadingHomeOtpState extends HomeOtpState{}

class FailToLoginHomeOtpState extends HomeOtpState{
  FailToLoginHomeOtpState(this.errorMessage);

  final String errorMessage;
}