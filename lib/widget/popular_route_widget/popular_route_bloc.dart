import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/route_repository.dart';
import 'package:meta/meta.dart';

part 'popular_route_event.dart';

part 'popular_route_state.dart';

class PopularRouteBloc extends Bloc<PopularRouteEvent, PopularRouteState> {
  PopularRouteBloc() : super(PopularRouteInitial());
  RouteRepository routeRepository = RouteRepository();

  @override
  Stream<PopularRouteState> mapEventToState(
    PopularRouteEvent event,
  ) async* {
    if (event is GetPopularPopularRouteEvent) {
      yield LoadingPopularRouteState();
      try {
        final List<RouteEntity> popularRouteList =
        await routeRepository.getPopularRoutes();
        yield DisplayPopularRouteState(popularRouteList);
      }
      on APIException catch(e){
        yield PopularRouteFailState(e.message());
      }
    }
  }
}
