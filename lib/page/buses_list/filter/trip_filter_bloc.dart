import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'trip_filter_event.dart';

part 'trip_filter_state.dart';

class TripFilterBloc extends Bloc<TripFilterEvent, TripFilterState> {
  TripFilterBloc() : super(TripFilterInitial(false, false));

  @override
  Stream<TripFilterState> mapEventToState(
    TripFilterEvent event,
  ) async* {
    final TripFilterState currentState = state;
    if (currentState is TripFilterInitial) {
      if (event is SortTripByTimeFilterEvent) {
        yield CallBackTripFilterState(!event.timeSort, currentState.priceSort);
        yield TripFilterInitial(!event.timeSort, currentState.priceSort);
      } else if (event is SortTripByPriceFilterEvent) {
        yield CallBackTripFilterState(currentState.timeSort, event.priceSort);
        yield TripFilterInitial(currentState.timeSort, !event.priceSort);
      }
    }
  }
}
