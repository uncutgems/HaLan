import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/repository/popup_repository.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());
  PopUpRepository popUpRepository = PopUpRepository();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetDataHomeEvent) {

      yield DisplayDataHomeState();
    }
  }
}
