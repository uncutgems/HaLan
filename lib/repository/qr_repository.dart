import 'package:halan/base/api_handler.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/url.dart';
import 'package:halan/model/entity.dart';

class QRRepository {
  Future<String> getQRCode(String listTicketId) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.ticketIds] = listTicketId;
    final AVResponse response =
        await callPOST(path: URL.generateQRCode, body: body);
    if (response.isOK) {
      final String qrString = getString(Constant.qrString,
          response.response[Constant.data] as Map<String, dynamic>);
      return qrString;
    } else {
      throw APIException(response);
    }
  }
}
