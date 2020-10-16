part of 'promotion_bloc.dart';

@immutable
abstract class PromotionWidgetState {}

class PromotionWidgetInitial extends PromotionWidgetState {}

class SuccessCheckPromotionState extends PromotionWidgetState {
  SuccessCheckPromotionState(this.promotionObject);

  final PromotionObject promotionObject;
}

class FailCheckPromotionState extends PromotionWidgetState {
  FailCheckPromotionState(this.error);

  final String error;
}

class CallBackPromotionState extends PromotionWidgetState {
  CallBackPromotionState(this.promotionObject);

  final PromotionObject promotionObject;
}
