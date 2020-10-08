import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:halan/base/url.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:halan/model/entity.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

bool _statusOk(int statusCode) {
  return statusCode >= 200 && statusCode <= 300;
}

///
/// Hàm gọi API lên Server bằng GET Method
/// [path] là đường link của API (Không phải Base URL). Đây là trường bắt buộc
/// [headers]  Không bắt buộc phải truyền vào trừ trường hợp muốn custom hoặc truyền thêm
///
Future<AVResponse> callGET(String url, {Map<String, String> headers}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final Map<String, String> _headers = <String, String>{};
  _headers[Constant.contentType] = 'application/json';
  _headers[Constant.headerDOBODY6969] = prefs.getString(Constant.token).toString();
  _headers.addAll(headers ?? <String, String>{});
  try {
    print('GET ===================== ');
    print('HEADER: $_headers');
    print('URL : $url');
    final Response response = await get(url, headers: _headers).timeout(const Duration(seconds: 30));
    if (response != null) {
      print('RESPONSE: ' + response.body);
    }
    AVResponse result;
    if (_statusOk(response.statusCode)) {
      result = AVResponse(
        code: response.statusCode,
        isOK: true,
        response: jsonDecode(response.body)[Constant.results] as Map<String, dynamic>,
      );
    } else {
      final Map<String, dynamic> jsonError =
          jsonDecode(response.body)[Constant.results][Constant.error] as Map<String, dynamic>;
      result = AVResponse(
        isOK: false,
        code: response.statusCode,
        response: jsonError,
        message: getErrorMessage(getInt(Constant.code, jsonError)),
      );
    }
    return result;
  } on TimeoutException catch (timeOutError) {
    print('API Timeout ${timeOutError.message}');
    throw APIException(AVResponse(
      isOK: false,
      code: 408,
      response: <String, dynamic>{},
      message: getErrorMessage(408),
    ));
  } catch (error) {
    print('API Exception $error');
    throw APIException(AVResponse(
      isOK: false,
      code: 100,
      response: <String, dynamic>{},
      message: getErrorMessage(100),
    ));
  }
}

Future<AVResponse> callPOST({
  @required String path,
  @required dynamic body,
  Map<String, String> header,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String _url = path;
  final Map<String, String> _headers = <String, String>{};
  _headers.addAll(header ?? <String, String>{});
  _headers[Constant.contentType] = 'application/json';
  _headers[Constant.headerDOBODY6969] = prefs.getString(Constant.token).toString();
//  _headers[Constant.headerDOBODY6969] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJUQzA4WjFxSEhaQnhsTkx0IiwiaXNzIjoiYW52dWkiLCJleHAiOjE2MDE0NTQ2NzUsImp0aSI6IlVTMElHMXU3QlJWNTVpMzAifQ.ulFjE7eaWdjOGooJuizggaC5yvCr-fP1XUNzPqM_1Mw";



  if (body is List) {
    for (final dynamic item in body) {
      item[Constant.packageName] = 'vn.anvui.driver';
      item[Constant.timeZone] = 7;
      item[Constant.platform] = 1;
      item[Constant.deviceType] = 1;
      item[Constant.companyId] = 'TC0FR1szrRt37fiR';
      item[Constant.fcmToken] = prefs.getString(Constant.firebaseKey);
      item[Constant.deviceId] = prefs.getString(Constant.deviceId);
    }
  } else {
    body[Constant.packageName] = 'vn.anvui.driver';
    body[Constant.timeZone] = 7;
    body[Constant.platform] = 3;
    body[Constant.deviceType] = 1;
    body[Constant.companyId] = 'TC0FR1szrRt37fiR';
    body[Constant.fcmToken] = prefs.getString(Constant.firebaseKey);
    body[Constant.deviceId] = prefs.getString(Constant.deviceId);
  }

  print('Calling post data ===============================================');
  print('header: $_headers');
  print('URL: $path');
  print('body: $body');
  try {
    final Response response =
        await post(_url, headers: _headers, body: jsonEncode(body)).timeout(const Duration(seconds: 30));
    if (response != null) {
      print('response: ' + response.body);
    }
    AVResponse result;
    if (_statusOk(response.statusCode)) {
      result = AVResponse(
        code: response.statusCode,
        isOK: true,
        response: json.decode(response.body)[Constant.results] as Map<String, dynamic>,
      );
    } else {
      final Map<String, dynamic> jsonError =
          json.decode(response.body)[Constant.results][Constant.error] as Map<String, dynamic>;
      result = AVResponse(
        isOK: false,
        code: response.statusCode,
        response: jsonError,
        message: getErrorMessage(getInt(Constant.code, jsonError)),
      );
    }
    return result;
  } on TimeoutException catch (timeOutError) {
    print('API Timeout ${timeOutError.message}');
    throw APIException(AVResponse(
      isOK: false,
      code: 408,
      response: <String, dynamic>{},
      message: getErrorMessage(408),
    ));
  } catch (error) {
    print('API Exception $error');
    throw APIException(AVResponse(
      isOK: false,
      code: 100,
      response: <String, dynamic>{},
      message: getErrorMessage(100),
    ));
  }
}

/// Lấy string lỗi theo mã
String getErrorMessage(int code) {
  switch (code) {
    case 108:
      return 'Tên đăng nhập hoặc mật khẩu không chính xác.';
    case 103:
      return 'Có lỗi xảy ra, vui lòng thử lại';
    case 122:
      return 'Sai tên đăng nhập hoặc mật khẩu';
    case 100:
      return 'Mất kết nối mạng.';
    case 107:
      return 'Bạn không có quyền thực hiện chức năng này';
    case 104:
      return 'Ghế đã có người đặt';
    case 110:
      return 'Ảnh không thể trống';
    case 408:
      return 'Không thể kết nối đến Server. Vui lòng kiểm trả kết nối mạng.';
    default:
      return 'Mất kết nối mạng. Vui lòng kiểm tra lại.';
  }
}

class APIException implements Exception {
  APIException(this.aVResponse);

  final AVResponse aVResponse;

  String message() {
    return aVResponse.message;
  }
}

class APIParse {
  static String listToString(String key, List<dynamic> values) {
    String request = '';
    for (final dynamic item in values) {
      request += '$key=$item&';
    }
    print('request $request');
    return request;
  }
}

Future<StreamedResponse> uploadImage(File file) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  const String _url = URL.uploadImage;
  final Map<String, String> headers = <String, String>{};
  headers[Constant.contentType] = 'multipart/form-data';
  headers[Constant.headerDOBODY6969] = prefs.getString(Constant.token);

  print('Calling upload image ===========================================');
  print('header: ' + headers.toString());
  print('URL: ' + _url);

  final Uri uri = Uri.parse(_url);
  final ByteStream stream = ByteStream(Stream.castFrom(file.openRead()));
  final int length = await file.length();

  final MultipartRequest request = MultipartRequest('POST', uri);
  final MultipartFile multipartFile = MultipartFile(
    'file',
    stream,
    length,
    filename: basename(file.path),
  );
  request.files.add(multipartFile);
  request.headers.addAll(headers);
  print('request' + request.headers.toString());
  final StreamedResponse response = await request.send();
  print(response.statusCode);
  return response;
}

