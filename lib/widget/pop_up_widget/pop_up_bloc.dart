import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/popup_repository.dart';
import 'package:meta/meta.dart';

part 'pop_up_event.dart';

part 'pop_up_state.dart';

class PopUpBloc extends Bloc<PopUpEvent, PopUpState> {
  PopUpBloc() : super(PopUpInitial());
  PopUpRepository popUpRepository = PopUpRepository();

  @override
  Stream<PopUpState> mapEventToState(
    PopUpEvent event,
  ) async* {
    if (event is GetDataPopUpEvent) {
      try {
        yield LoadingPopUpState();
        final List<PopUp> promotionList =
        await popUpRepository.getPromotionsDummy();
        yield DisplayPopUpState(promotionList);
      } on APIException catch(e){
        print('hass');
        yield FailPopUpState(e.message());
      }
    }
  }
}
