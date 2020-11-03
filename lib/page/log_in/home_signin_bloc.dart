import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/base/config.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/main.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'home_signin_event.dart';

part 'home_signin_state.dart';

class HomeSignInBloc extends Bloc<HomeSignInEvent, HomeSignInState> {
  HomeSignInBloc() : super(HomeSignInInitial());
  UserRepository userRepository = UserRepository();
  LoginType login = LoginType.call;
  @override
  Stream<HomeSignInState> mapEventToState(
    HomeSignInEvent event,
  ) async* {
    if (event is ClickLogInButtonHomeSignInEvent) {

      try {
        yield LoadingHomeSignInState();
        if(login == LoginType.sendMessage) {
          await userRepository.getOTPCode(event.phoneNumber);
        }
        else if (login == LoginType.call){
          final PhoneNumber phoneNumber = await userRepository.call(event.phoneNumber, 84, companyId);
          prefs.setString(Constant.phoneNumberId, phoneNumber.id);
        }
//        yield DismissLoadingHomeSignInState();
        yield MoveToNextPageHomeSignInState(event.phoneNumber);
      } on APIException catch (e) {
        yield FailHomeSignInState(e.message());
      }
    }
  }
}
