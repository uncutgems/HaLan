part of 'home_signin_bloc.dart';

@immutable
abstract class HomeSignInEvent {}


class ClickLogInButtonHomeSignInEvent extends HomeSignInEvent{

  ClickLogInButtonHomeSignInEvent(this.phoneNumber);

  final String phoneNumber;


}

