part of 'promotion_bloc.dart';

@immutable
abstract class PromotionState {}

class PromotionInitial extends PromotionState {
  PromotionInitial(this.promotionList);
  final List<PopUp> promotionList;
}
class PromotionStateLoading extends PromotionState{}
class PromotionStateDismissLoading extends PromotionState{}
class PromotionStateFail extends PromotionState{
  PromotionStateFail(this.error);
  final String error;
}