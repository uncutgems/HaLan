import 'package:halan/base/api_handler.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/url.dart';
import 'package:halan/model/entity.dart';

class PopUpRepository {
  Future<List<PopUp>> getPromotions() async {
    final List<PopUp> promotionList = <PopUp>[];
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.companyId] = 'TC0FR1szrRt37fiR';
    final AVResponse response = await callPOST(path: URL.getPopUp, body: body);
    if (response.isOK) {
      response.response[Constant.popUps].forEach((final dynamic itemJson) {
        promotionList.add(PopUp.fromJson(itemJson as Map<String, dynamic>));
      });
      return promotionList;
    } else {
      throw APIException(response);
    }
  }

  Future<List<PopUp>> getPromotionsDummy() async {
    final List<PopUp> promotionList = <PopUp>[];
    final Map<String, dynamic> body = <String, dynamic>{};
    final AVResponse response = await callPOST(path: URL.getPopUp, body: body);
    if (response.isOK) {
      response.response[Constant.popUps].forEach((final dynamic itemJson) {
        promotionList.add(PopUp.fromJson(itemJson as Map<String, dynamic>));
      });
      return promotionList;
    } else {
      throw APIException(response);
    }
  }
}
