import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/main.dart';
import 'package:halan/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'home_otp_event.dart';

part 'home_otp_state.dart';

class HomeOtpBloc extends Bloc<HomeOtpEvent, HomeOtpState> {
  HomeOtpBloc() : super(HomeOtpInitial());
  UserRepository userRepository = UserRepository();

  @override
  Stream<HomeOtpState> mapEventToState(
    HomeOtpEvent event,
  ) async* {
    if (event is ClickSendAgainHomeOtpEvent) {
      try {
        await userRepository.getOTPCode(event.phoneNumber);
        yield ReloadPageHomeOtpState();
      } on APIException catch (e) {
        yield FailToLoginHomeOtpState(e.message());
      }
    } else if (event is ClickLogInButtonHomeOtpEvent) {
      yield LoadingHomeOtpState();
      try {
        await userRepository.loginOTP(event.phoneNumber, event.otpCode);
        yield DismissLoadingHomeOtpState();
//        prefs.setString(Constant, value)
        yield LogInSuccessfullyHomeOtpState();
      } on APIException catch (e) {
        yield DismissLoadingHomeOtpState();
        yield FailToLoginHomeOtpState(e.message());
      }
    }
  }
}
