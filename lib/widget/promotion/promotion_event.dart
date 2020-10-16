part of 'promotion_bloc.dart';

@immutable
abstract class PromotionWidgetEvent {}

class CheckPromotionCodeEvent extends PromotionWidgetEvent {
  CheckPromotionCodeEvent(
      {@required this.promotionCode,
      @required this.routeId,
      @required this.userId});

  final String promotionCode;
  final String routeId;
  final String userId;
}
