import 'package:halan/base/api_handler.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/url.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/home_page/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class UserRepository {
  Future<void> getOTPCode(String phoneNumber) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.companyId] = 'TC1OHntfnujP';
    body[Constant.phoneNumber] = phoneNumber;
    body[Constant.stateCode] = 84;

    final AVResponse response =
        await callPOST(path: URL.getOTPCode, body: body);
    if (response.isOK) {
      print('Successfully');
    } else {
      throw APIException(response);
    }
  }

  Future<void> loginOTP(String phoneNumber, String otpCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.companyId] = 'TC1OHntfnujP';
    body[Constant.phoneNumber] = phoneNumber;
    body[Constant.stateCode] = 84;
    body[Constant.otpCode] = otpCode;

    final AVResponse response = await callPOST(path: URL.loginURL, body: body);
    if (response.isOK) {
      print('Login successfully');
      prefs.setString(
          Constant.fullName,
          getString(Constant.fullName,
              response.response[Constant.token] as Map<String, dynamic>));
      prefs.setString(
          Constant.phoneNumber,
          getString(Constant.phoneNumber,
              response.response[Constant.token] as Map<String, dynamic>));
      prefs.setString(
          Constant.avatar,
          getString(Constant.avatar,
              response.response[Constant.token] as Map<String, dynamic>));
    } else {
      throw APIException(response);
    }
  }
}
