import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/popup_repository.dart';
import 'package:meta/meta.dart';

part 'promotion_event.dart';
part 'promotion_state.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  PromotionBloc() : super(PromotionInitial(const <PopUp>[]));
  PopUpRepository repository = PopUpRepository();
  @override
  Stream<PromotionState> mapEventToState(
    PromotionEvent event,
  ) async* {
    if(event is PromotionEventGetPromotions){
      try {
        yield PromotionStateLoading();
        final List<PopUp> promotionList = await repository.getPromotions();

        print(DateTime.fromMillisecondsSinceEpoch(promotionList.first.endDate).month);
//        yield PromotionStateDismissLoading();
        yield PromotionInitial(promotionList);

      }
      on APIException catch(e){
//        yield PromotionStateDismissLoading();
        yield PromotionStateFail(e.message());
      }
    }
  }
}
