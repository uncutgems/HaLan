part of 'home_signin_bloc.dart';

@immutable
abstract class HomeSignInState {}

class HomeSignInInitial extends HomeSignInState {}

class MoveToNextPageHomeSignInState extends HomeSignInState {
  MoveToNextPageHomeSignInState(this.phoneNumber);

  final String phoneNumber;
}

class LoadingHomeSignInState extends HomeSignInState{}

class DismissLoadingHomeSignInState extends HomeSignInState{}

class FailHomeSignInState extends HomeSignInState {
  FailHomeSignInState(this.errorMessage);

  final String errorMessage;
}
