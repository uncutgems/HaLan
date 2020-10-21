import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'bus_list_item_event.dart';
part 'bus_list_item_state.dart';

class BusListItemBloc extends Bloc<BusListItemEvent, BusListItemState> {
  BusListItemBloc() : super(BusListItemInitial(Size.zero));

  @override
  Stream<BusListItemState> mapEventToState(
    BusListItemEvent event,
  ) async* {
    if(event is ChangingSizeBusListItemEvent) {
      yield BusListItemInitial(event.size);
    }
  }
}
