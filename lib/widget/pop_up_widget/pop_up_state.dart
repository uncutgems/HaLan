part of 'pop_up_bloc.dart';

@immutable
abstract class PopUpState {}

class PopUpInitial extends PopUpState {}

class LoadingPopUpState extends PopUpState {}

class DismissLoadingPopUpState extends PopUpState {}

class DisplayPopUpState extends PopUpState {
  DisplayPopUpState(this.promotionList);

  final List<PopUp> promotionList;
}


class FailPopUpState extends PopUpState{
  FailPopUpState(this.errorMessage);

  final String errorMessage;



}
