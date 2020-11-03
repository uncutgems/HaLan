import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/route_repository.dart';
import 'package:meta/meta.dart';
import 'package:halan/main.dart';
part 'select_place_event.dart';
part 'select_place_state.dart';

class SelectPlaceBloc extends Bloc<SelectPlaceEvent, SelectPlaceState> {
  SelectPlaceBloc() : super(SelectPlaceInitial());
  final RouteRepository repository = RouteRepository();
  @override
  Stream<SelectPlaceState> mapEventToState(
    SelectPlaceEvent event,
  ) async* {
    if (event is SelectPlaceEventGetData){
    print(']]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
    print(jsonDecode(prefs.getString(Constant.routes)));
    final List<RouteEntity> routes = <RouteEntity>[];
    jsonDecode(prefs.getString(Constant.routes)).forEach((final dynamic itemJson) {
    routes.add(RouteEntity.fromMap(itemJson as Map<String, dynamic>));
    });
        final List<Point> startPoints = getStartingPoints(routes);
        yield SelectPlaceStateShowData(startPoints,routes);
      }
    else if (event is SelectPlaceEventChooseScenario){
      yield SelectPlaceStateInitiateScenario(event.scenario,event.points);
    }
    else if (event is SelectPlaceEventReset){
      yield SelectPlaceStateReset(event.points);
    }
    else if (event is SelectPlaceEventChooseStartPoint){
      yield SelectPlaceStateShowStartPoint(event.scenario,event.points,event.startPoint);
    }
    else if (event is SelectPlaceEventChooseEndPoint){
      yield SelectPlaceStateShowDropOffPoint(event.scenario,event.points,event.endPoint);
    }
  }
}
