part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}
class SplashStateFail extends SplashState{
  SplashStateFail(this.error);
  final String error;
}
class SplashStateForward extends SplashState{}