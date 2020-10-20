import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/route_repository.dart';
import 'package:meta/meta.dart';
import 'package:halan/main.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial());
  RouteRepository repository = RouteRepository();
  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is SplashEventGetData) {
      try {
        final List<RouteEntity> routes = await repository.getAllRoutes();
        for (final RouteEntity route in routes) {
          for (final Point point in route.listPoint) {
            if (point.name.trim() == 'Thái Nguyên') {
              route.listPoint.forEach((element) {
                printPoint(element);
              });
            }
          }
        }
        prefs.setString(Constant.routes, jsonEncode(routes));
        yield SplashStateForward();
      }
      on APIException catch(e){
        yield SplashStateFail(e.message());
      }
    }
  }
}
