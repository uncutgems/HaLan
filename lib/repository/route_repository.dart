import 'package:halan/base/api_handler.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/url.dart';
import 'package:halan/model/entity.dart';

class RouteRepository {
  Future<List<RouteEntity>> getAllRoutes() async {
    final List<RouteEntity> routeList = <RouteEntity>[];

    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.companyId] = Constant.haLanCompanyId;

    final AVResponse response =
        await callPOST(path: URL.getRouteList, body: <String, dynamic>{});
    if (response.isOK) {
      response.response[Constant.result].forEach((final dynamic itemJson) {
        routeList.add(RouteEntity.fromMap(itemJson as Map<String, dynamic>));
      });
      print(routeList.length);
      return routeList;
    } else {
      throw APIException(response);
    }
  }

  Future<List<RouteEntity>> getPopularRoutes() async {
    final List<RouteEntity> popularRouteList = <RouteEntity>[];
//    final Map<String, dynamic> body = <String, dynamic>{};
//    body[Constant.companyId] = 'TC0FR1szrRt37fiR';

    final AVResponse response = await callGET(URL.getPopularRouteList);
    if (response.isOK) {
      response.response[Constant.result].forEach((final dynamic itemJson) {
        popularRouteList
            .add(RouteEntity.fromMap(itemJson as Map<String, dynamic>));
      });
      print(popularRouteList.length);
      return popularRouteList;
    } else {
      throw APIException(response);
    }
  }
  Future<RouteEntity> showRoute(String id, {String vehicleTypeId}) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.id] = id;
    final AVResponse result = await callPOST(path: URL.viewRoute, body: body);
    RouteEntity routeEntity = RouteEntity();
    if (result.isOK) {
      routeEntity = RouteEntity.fromMap(
          result.response[Constant.route] as Map<String, dynamic>);

      return routeEntity;
    } else
      throw APIException(result);
  }
}
