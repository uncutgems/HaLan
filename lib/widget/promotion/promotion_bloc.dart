import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/promotion_repository.dart';
import 'package:meta/meta.dart';

part 'promotion_event.dart';

part 'promotion_state.dart';

class PromotionWidgetBloc
    extends Bloc<PromotionWidgetEvent, PromotionWidgetState> {
  PromotionWidgetBloc() : super(PromotionWidgetInitial());

  final PromotionRepository _promotionRepository = PromotionRepository();

  @override
  Stream<PromotionWidgetState> mapEventToState(
    PromotionWidgetEvent event,
  ) async* {
    if (event is CheckPromotionCodeEvent) {
      try {
        yield SuccessCheckPromotionState(PromotionObject(promotionId: '-1'));

        final PromotionObject promotionObject =
            await _promotionRepository.checkPromotionCode(
                promotionCode: event.promotionCode,
                userId: event.userId,
                routeId: event.routeId);
        yield CallBackPromotionState(promotionObject);
        yield SuccessCheckPromotionState(promotionObject);
      } on APIException catch (e) {
        yield CallBackPromotionState(PromotionObject());
        yield FailCheckPromotionState(e.message());
      }
    }
  }
}
