part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class DisplayDataHomeState extends HomeState {

}

class LoadingHomeState extends HomeState {}

class DismissLoadingHomeState extends HomeState {}
