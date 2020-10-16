import 'package:flutter/cupertino.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/url.dart';
import 'package:halan/model/entity.dart';

class PromotionRepository {
  Future<PromotionObject> checkPromotionCode(
      {@required String promotionCode,
      @required String userId,
      @required String routeId}) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.promotionCode] = promotionCode;
    body[Constant.userId] = userId;
    body[Constant.routeId] = routeId;
    final AVResponse response =
        await callPOST(path: URL.checkPromotion, body: body);
    if (response.isOK) {
      final PromotionObject promotionObject = PromotionObject.fromMap(
          response.response[Constant.result] as Map<String, dynamic>);
      return promotionObject;
    } else {
      throw APIException(response);
    }
  }
}
