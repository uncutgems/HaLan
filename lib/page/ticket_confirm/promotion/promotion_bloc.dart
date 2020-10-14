import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'promotion_event.dart';
part 'promotion_state.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  PromotionBloc() : super(PromotionInitial());

  @override
  Stream<PromotionState> mapEventToState(
    PromotionEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
