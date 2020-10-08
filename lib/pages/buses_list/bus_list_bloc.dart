import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/pages/repository/trip_repository.dart';
import 'package:meta/meta.dart';

part 'bus_list_event.dart';

part 'bus_list_state.dart';

class BusListBloc extends Bloc<BusListEvent, BusListState> {
  BusListBloc() : super(BusListInitial());

  final TripRepository _tripRepository = TripRepository();

  @override
  Stream<BusListState> mapEventToState(
    BusListEvent event,
  ) async* {
    if (event is GetDataBusListEvent) {
      try {
        final List<Trip> tripList = await _tripRepository.getSchedule(
            event.startPoint, event.endPoint, event.date, 0, 86400000);
        yield SuccessGetDataBusListState(tripList);
      } on APIException catch (e) {
        yield FailGetDataBusListState(e.message());
      }
    }
  }
}
