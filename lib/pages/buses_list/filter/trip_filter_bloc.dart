import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'trip_filter_event.dart';
part 'trip_filter_state.dart';

class TripFilterBloc extends Bloc<TripFilterEvent, TripFilterState> {
  TripFilterBloc() : super(TripFilterInitial(const Key('')));

  @override
  Stream<TripFilterState> mapEventToState(
    TripFilterEvent event,
  ) async* {
    if(event is SortTripFilterEvent) {
      yield TripFilterInitial(event.key);
      yield CallBackTripFilterState(event.key);
    }
  }
}
