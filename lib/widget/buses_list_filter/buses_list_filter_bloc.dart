import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/route_repository.dart';
import 'package:meta/meta.dart';

part 'buses_list_filter_event.dart';
part 'buses_list_filter_state.dart';

class BusesListFilterBloc extends Bloc<BusesListFilterEvent, BusesListFilterState> {
  BusesListFilterBloc() : super(BusesListFilterInitial(0));
  final RouteRepository repository = RouteRepository();
  @override
  Stream<BusesListFilterState> mapEventToState(
    BusesListFilterEvent event,
  ) async* {
    if(event is BusesListFilterEventClickTime){

      final List<RouteEntity> routes = await repository.getAllRoutes();
      for(final Point point in routes[0].listPoint){
        print(point.name);
      }

//      const String nb = 'Thái Nguyên';
//
//      for(final RouteEntity routeEntity in routes){
//        for(Point point in routeEntity.listPoint){
//          if(point.name.trim()==nb){
//            print(true);
//          }
//        }
//      }
      yield BusesListFilterInitial(event.time);
    }
  }
}
