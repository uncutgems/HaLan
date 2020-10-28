import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

part 'buses_list_filter_event.dart';
part 'buses_list_filter_state.dart';

class BusesListFilterBloc extends Bloc<BusesListFilterEvent, BusesListFilterState> {
  BusesListFilterBloc() : super(BusesListFilterInitial(0));
  @override
  Stream<BusesListFilterState> mapEventToState(
    BusesListFilterEvent event,
  ) async* {
    if(event is BusesListFilterEventClickTime){


      yield BusesListFilterInitial(event.time);
    }
  }
}
