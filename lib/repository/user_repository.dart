import 'dart:convert';

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
  Future<String> getTokenFirebase() async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.email]='ticketSeller@gmail.com';
    body[Constant.password] = 'AnVui@2018';
    body[Constant.returnSecureToken] = true;

    final Response response = await post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDfTU9GbADEYoWtHs2JV951DbxFHybdM3c',
      body: jsonEncode({"email": "ticketSeller@gmail.com", "password": "AnVui@2018", "returnSecureToken": true}),
    );
    if (response != null) print('response: ' + response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final String idToken = jsonDecode(response.body)['idToken'] as String;
      print('refresh $idToken');
      return idToken;
    } else {
      return null;
    }
  }
}
