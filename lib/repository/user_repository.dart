import 'dart:convert';
import 'dart:io';

import 'package:halan/base/api_handler.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/url.dart';
import 'package:halan/model/entity.dart';
import 'package:http/http.dart';

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
      print(prefs.getString(Constant.phoneNumber));
    } else {
      throw APIException(response);
    }
  }

  Future<String> uploadImageUrl(File file) async {
    final StreamedResponse response = await uploadImage(file);
    String imageURL;
    final String rep = await response.stream.bytesToString();
    print('String=== $rep');

    final Map<String, dynamic> json = jsonDecode(rep) as Map<String, dynamic>;
    print('Json $json');
    if (json['code'] >= 200 != null && json['code'] <= 300 != null) {
      imageURL =
          json[Constant.results]['listImages'][0]['gcsServingUrl'].toString();
    }

    print('CHECKING OUTPUT ===========$imageURL');
    return imageURL;
  }

  Future<void> updateUserInfo(String id, String userName, String userPhone,
      String imageURL) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.userId] = id;
    body[Constant.phoneNumber] = userPhone;
    body[Constant.fullName] = userName;
    body[Constant.avatar] = imageURL;
    const String _url = URL.updateUserInfo;

    final AVResponse response = await callPOST(path: _url, body: body);
    if (response.isOK) {
      print('Update userInfo successfully');
      prefs.setString(
          Constant.fullName,
          getString(Constant.fullName,
              response.response[Constant.userInfo] as Map<String, dynamic>));
      prefs.setString(
          Constant.phoneNumber,
          getString(Constant.phoneNumber,
              response.response[Constant.userInfo] as Map<String, dynamic>));
      prefs.setString(
          Constant.avatar,
          getString(Constant.avatar,
              response.response[Constant.userInfo] as Map<String, dynamic>));
      prefs.setString(
          Constant.id,
          getString(Constant.id,
              response.response[Constant.userInfo] as Map<String, dynamic>));
    } else {
      throw APIException(response);
    }
  }
}
