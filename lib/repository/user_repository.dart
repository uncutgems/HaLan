import 'package:halan/base/api_handler.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/url.dart';
import 'package:halan/model/entity.dart';

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
//    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.companyId] = 'TC1OHntfnujP';
    body[Constant.phoneNumber] = phoneNumber;
    body[Constant.stateCode] = 84;
    body[Constant.otpCode] = otpCode;

    final AVResponse response = await callPOST(path: URL.loginURL, body: body);
    if (response.isOK) {
      print('Login successfully');

      prefs.setString(Constant.userId,
          response.response[Constant.userInfo][Constant.id] as String);
      prefs.setString(Constant.token,
          response.response[Constant.token][Constant.tokenKey] as String);
      prefs.setString(Constant.fullName,
          response.response[Constant.userInfo][Constant.fullName] as String);
      prefs.setString(Constant.phoneNumber,
          response.response[Constant.userInfo][Constant.phoneNumber] as String);
      prefs.setString(Constant.avatar,
          response.response[Constant.userInfo][Constant.avatar] as String);
    } else {
      throw APIException(response);
    }
  }
}
