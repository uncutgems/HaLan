import 'package:halan/base/api_handler.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/url.dart';
import 'package:halan/model/entity.dart';

class UserRepository {
  Future<void> getOTPCode(String phoneNumber) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.companyId] = 'TC1OHntfnujP';
    body[Constant.phoneNumber] = phoneNumber;
    body[Constant.stateCode] = 84;

    final AVResponse response =
        await callPOST(path: URL.getOTPCode, body: body);
    if (response.isOK) {
    } else {
      throw APIException(response);
    }
  }

  Future<void> loginOTP(
      String phoneNumber, String stateCode, String otpCode) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.companyId] = 'TC1OHntfnujP';
    body[Constant.phoneNumber] = phoneNumber;
    body[Constant.stateCode] = stateCode;
    body[Constant.otpCode] = otpCode;

    final AVResponse response =
        await callPOST(path: URL.getOTPCode, body: <String, dynamic>{});
    if (response.isOK) {
    } else {
      throw APIException(response);
    }
  }
}
