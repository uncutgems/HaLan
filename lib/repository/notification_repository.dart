
import 'package:halan/base/api_handler.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/url.dart';
import 'package:halan/model/entity.dart';

class NotificationRepository {
  Future<List<NotificationEntity>> showNotification(int page, int count) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.page] = page;
    body[Constant.count] = count;
    final AVResponse result =
    await callPOST(path: URL.getListNotification, body: body);
    final List<NotificationEntity> notificationList = <NotificationEntity>[];
    if (result.isOK) {
      result.response[Constant.result].forEach((final dynamic itemJson) {
        final NotificationEntity notification =
        NotificationEntity.fromMap(itemJson as Map<String, dynamic>);
        notificationList.add(notification);
      });
      return notificationList;
    } else {
      throw APIException(result);
    }
  }

  Future<NotificationEntity> readNotification(String notificationId) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.notificationId] = notificationId;
    final AVResponse response = await callPOST(path: URL.readNotification, body: body);
    if (response.isOK) {
//      print('Hello is read ${ response.response as Map<String, dynamic>}');
      final NotificationEntity notification = NotificationEntity.fromMap(
          response.response['Notification'] as Map<String, dynamic>);
//      print('Hello is read ${ notification.isRead}');
      return notification;
//     final NotificationObject notificationObject =  response.response[Constant.result]['Notification'];
    }
    else {
      throw APIException(response);
    }
  }
}
