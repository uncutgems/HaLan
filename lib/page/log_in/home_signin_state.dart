part of 'home_signin_bloc.dart';

@immutable
abstract class HomeSignInState {}

class HomeSignInInitial extends HomeSignInState {}

class MoveToNextPageHomeSignInState extends HomeSignInState {}

class FailHomeSignInState extends HomeSignInState {
  FailHomeSignInState(this.errorMessage);

  final String errorMessage;
}
