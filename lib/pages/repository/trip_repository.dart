import 'package:halan/base/api_handler.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/url.dart';
import 'package:halan/model/entity.dart';

class TripRepository {
  Future<List<Trip>> getSchedule(
      String startPoint, String endPoint,int date, int startTimeLimit, int endTimeLimit) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.date] = date;
    body[Constant.page] = 0;
    body[Constant.count] = 10;
    body[Constant.startPoint] = startPoint;
    body[Constant.endPoint] = endPoint;
    body[Constant.startTimeLimit] = startTimeLimit;
    body[Constant.endTimeLimit] = endTimeLimit;
    final AVResponse result = await callPOST(path: URL.getSchedule, body: body);
    final List<Trip> tripList = <Trip>[];
    if (result.isOK) {
      result.response[Constant.trips].forEach((final dynamic itemJson) {
        final Trip trip = Trip.fromMap(itemJson as Map<String, dynamic>);

        tripList.add(trip);
      });

      return tripList;
    } else {
      throw APIException(result);
    }
  }
}
