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
    body[Constant.companyId] = Constant.haLanCompanyId;
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
      {String imageURL}) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.userId] = id;
    body[Constant.phoneNumber] = userPhone;
    body[Constant.fullName] = userName;
    if(imageURL != null){
      body[Constant.avatar] = imageURL;
    }

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
      prefs.setString(Constant.avatar,
          response.response[Constant.userInfo][Constant.avatar] as String);
      prefs.setString(
          Constant.id,
          getString(Constant.id,
              response.response[Constant.userInfo] as Map<String, dynamic>));
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
      body: jsonEncode(<String,dynamic>{'email': 'ticketSeller@gmail.com', 'password': 'AnVui@2018', 'returnSecureToken': true}),
    );
    if (response != null){
      print('response: ' + response.body);
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final String idToken = jsonDecode(response.body)['idToken'] as String;
      print('refresh $idToken');
      return idToken;
    } else {
      throw Exception(response);
//      return null;
    }
  }
  Future<PhoneNumber> call(String phoneNumber,int stateCode,String companyId) async {
    final Map<String,dynamic> body = <String,dynamic>{};
    body['phoneNumber']=phoneNumber;
    body['stateCode'] = stateCode;
    body['companyId'] = companyId;

    final AVResponse response = await callPOST(path: URL.sendOTPCall,body: body);
    if (response.isOK) {
//      print('response is here ${response.response[Constant.data]}');
      final PhoneNumber phoneNumber = PhoneNumber.fromMap(response.response[Constant.data] as Map<String,dynamic>);
//        print('Hello ${phoneNumber.id}');
      return phoneNumber;
    }
    else {
      throw APIException(response);
    }
  }
  Future<PinNumber> validatePin(String id,int stateCode,String companyId,String pin) async {
    final Map<String,dynamic> body = <String,dynamic>{};
    body['id']=id;
    body['stateCode'] = stateCode;
    body['companyId'] = companyId;
    body['pin'] = pin;
    final AVResponse response = await callPOST(path: URL.loginOTPCall,body: body);
    if (response.isOK) {
      print('response is here ${response.response[Constant.userInfo]}');
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
      final PinNumber pinNumber = PinNumber.fromMap(response.response[Constant.userInfo] as Map<String,dynamic>);
      print('Hello ${pinNumber.id}');
      return pinNumber;
    }
    else {
      throw APIException(response);
    }
  }
}
