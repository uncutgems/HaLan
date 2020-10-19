import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/trip_repository.dart';
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
    final BusListState currentState = state;
    if (event is GetDataBusListEvent) {
      yield* _mapGetDataBusListEventToState(
          event.startPoint, event.endPoint, event.date, 0, <Trip>[]);
    }
    if (currentState is SuccessGetDataBusListState) {
      if (event is LoadMoreBusListEvent) {
        yield* _mapGetDataBusListEventToState(
            currentState.startPoint,
            currentState.endPoint,
            currentState.dateSelected,
            currentState.page + 1,
            currentState.listTrip,
            sortSelection: currentState.sortSelections);
      } else if (event is SortListGetDataBusListEvent) {
        if (event.sortTypes.first == true && event.sortTypes.last == true) {
          yield* _mapGetDataBusListEventToState(currentState.startPoint,
              currentState.endPoint, currentState.dateSelected, 0, <Trip>[],
              sortSelection: <SortSelection>[
                SortSelection(fieldName: 'startTime', ascDirection: true),
                SortSelection(fieldName: 'price', ascDirection: true)
              ]);
        } else if (event.sortTypes.first == false &&
            event.sortTypes.last == true) {
          yield* _mapGetDataBusListEventToState(currentState.startPoint,
              currentState.endPoint, currentState.dateSelected, 0, <Trip>[],
              sortSelection: <SortSelection>[
                SortSelection(fieldName: 'price', ascDirection: true)
              ]);
        } else if (event.sortTypes.first == true &&
            event.sortTypes.last == false) {
          yield* _mapGetDataBusListEventToState(currentState.startPoint,
              currentState.endPoint, currentState.dateSelected, 0, <Trip>[],
              sortSelection: <SortSelection>[
                SortSelection(fieldName: 'startTime', ascDirection: true)
              ]);
        } else {
          yield* _mapGetDataBusListEventToState(currentState.startPoint,
              currentState.endPoint, currentState.dateSelected, 0, <Trip>[],
              sortSelection: <SortSelection>[]);
        }
      } else if (event is SortTimePeriodBusListEvent) {
        yield* _mapGetDataBusListEventToState(
            currentState.startPoint,
            currentState.endPoint,
            currentState.dateSelected,
            currentState.page,
            currentState.listTrip,
            sortSelection: currentState.sortSelections,
            startTime: event.startTime,
            endTime: event.endTime);
      }
    }
  }

  Stream<BusListState> _mapGetDataBusListEventToState(String startPoint,
      String endPoint, DateTime date, int page, List<Trip> tripList,
      {List<SortSelection> sortSelection, int startTime, int endTime}) async* {
    try {
      yield SuccessGetDataBusListState(tripList, -1, date, startPoint, endPoint,
          false, const <SortSelection>[]);
      final List<Trip> newTripList = <Trip>[];
      newTripList.addAll(tripList);
      newTripList.addAll(await _tripRepository.getSchedule(
          startPoint: startPoint,
          endPoint: endPoint,
          date: int.parse(
              convertTime('yyyyMMdd', date.millisecondsSinceEpoch, false)),
          startTimeLimit: startTime ?? 0,
          endTimeLimit: endTime ?? 86400000,
          page: page,
          sortSelections: sortSelection));
      yield SuccessGetDataBusListState(
          newTripList, page, date, startPoint, endPoint, true, sortSelection);
    } on APIException catch (e) {
      yield FailGetDataBusListState(e.message());
    }
  }
}
