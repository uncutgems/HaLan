import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/route_repository.dart';
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
