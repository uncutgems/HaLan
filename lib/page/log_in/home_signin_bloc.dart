import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'home_signin_event.dart';

part 'home_signin_state.dart';

class HomeSignInBloc extends Bloc<HomeSignInEvent, HomeSignInState> {
  HomeSignInBloc() : super(HomeSignInInitial());
  UserRepository userRepository = UserRepository();

  @override
  Stream<HomeSignInState> mapEventToState(
    HomeSignInEvent event,
  ) async* {
    if (event is ClickLogInButtonHomeSignInEvent) {
      try {
        yield LoadingHomeSignInState();
        await userRepository.getOTPCode(event.phoneNumber);
//        yield DismissLoadingHomeSignInState();
        yield MoveToNextPageHomeSignInState(event.phoneNumber);
      } on APIException catch (e) {
        yield FailHomeSignInState(e.message());
      }
    }
  }
}
