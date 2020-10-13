import 'dart:math';
import 'package:halan/model/entity.dart';
import 'package:intl/intl.dart';

int jdFromDate(int dd, int mm, int yy) {
  final int a = (14 - mm) ~/ 12;
  final int y = yy + 4800 - a;
  final int m = mm + 12 * a - 3;
  int jd = dd +
      ((153 * m + 2) ~/ 5) +
      365 * y +
      (y ~/ 4) -
      (y ~/ 100) +
      (y ~/ 400) -
      32045;
  if (jd < 2299161) {
    jd = dd + ((153 * m + 2) ~/ 5) + 365 * y + (y ~/ 4) - 32083;
  }
  return jd;
}

int getNewMoonDay(int k, int timeZone) {
  final int T = k ~/ 1236.85;
  final int t2 = T * T;
  final int t3 = t2 * T;
  final double dr = pi / 180;
  double jd1 =
      2415020.75933 + 29.53058868 * k + 0.0001178 * t2 - 0.000000155 * t3;
  jd1 = jd1 + 0.00033 * sin((166.56 + 132.87 * T - 0.009173 * t2) * dr);
  final double M =
      359.2242 + 29.10535608 * k - 0.0000333 * t2 - 0.00000347 * t3;
  final double mpr =
      306.0253 + 385.81691806 * k + 0.0107306 * t2 + 0.00001236 * t3;
  final double F =
      21.2964 + 390.67050646 * k - 0.0016528 * t2 - 0.00000239 * t3;
  double c1 = (0.1734 - 0.000393 * T) * sin(M * dr) + 0.0021 * sin(2 * dr * M);
  c1 = c1 - 0.4068 * sin(mpr * dr) + 0.0161 * sin(dr * 2 * mpr);
  c1 = c1 - 0.0004 * sin(dr * 3 * mpr);
  c1 = c1 + 0.0104 * sin(dr * 2 * F) - 0.0051 * sin(dr * (M + mpr));
  c1 = c1 - 0.0074 * sin(dr * (M - mpr)) + 0.0004 * sin(dr * (2 * F + M));
  c1 = c1 - 0.0004 * sin(dr * (2 * F - M)) - 0.0006 * sin(dr * (2 * F + mpr));
  c1 = c1 + 0.0010 * sin(dr * (2 * F - mpr)) + 0.0005 * sin(dr * (2 * mpr + M));
  double deltat = 0;
  if (T < -11) {
    deltat = 0.001 +
        0.000839 * T +
        0.0002261 * t2 -
        0.00000845 * t3 -
        0.000000081 * T * t3;
  } else {
    deltat = -0.000278 + 0.000265 * T + 0.000262 * t2;
  }
  final double jdNew = jd1 + c1 - deltat;
  return (jdNew + 0.5 + timeZone / 24).toInt();
}

int getLeapMonthOffset(int a11, int timeZone) {
  final int k = ((a11 - 2415021.076998695) / 29.530588853 + 0.5).toInt();
  int last = 0;
  int i = 1;
  int arc = getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone);
  while (arc != last && i < 14) {
    last = arc;
    i = i + 1;
    arc = getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone);
  }
  return i - 1;
}

int getSunLongitude(int jdn, int timeZone) {
  final double T = (jdn - 2451545.5 - timeZone / 24) / 36525;
  final double t2 = T * T;
  final double dr = pi / 180;
  final double M =
      357.52910 + 35999.05030 * T - 0.0001559 * t2 - 0.00000048 * T * t2;
  final double l0 = 280.46645 + 36000.76983 * T + 0.0003032 * t2;
  double dL = (1.914600 - 0.004817 * T - 0.000014 * t2) * sin(dr * M);
  dL = dL +
      (0.019993 - 0.000101 * T) * sin(dr * 2 * M) +
      0.000290 * sin(dr * 3 * M);
  double L = l0 + dL;
  L = L * dr;
  L = L - pi * 2 * (L ~/ (pi * 2));
  return (L / pi * 6).toInt();
}

int getLunarMonth11(int yy, int timeZone) {
  final int off = jdFromDate(31, 12, yy) - 2415021;
  final int k = off ~/ 29.530588853;
  int nm = getNewMoonDay(k, timeZone);
  final int sunLong = getSunLongitude(nm, timeZone);
  if (sunLong >= 9) {
    nm = getNewMoonDay(k - 1, timeZone);
  }
  return nm;
}

DateTime convertSolar2Lunar(int dd, int mm, int yy, int timeZone) {
  final int dayNumber = jdFromDate(dd, mm, yy);
  final int k = (dayNumber - 2415021.076998695) ~/ 29.530588853;
  int monthStart = getNewMoonDay(k + 1, timeZone);

  int lunarYear, lunarMonth, lunarDay, lunarLeap, diff, leapMonthDiff, a11, b11;
  if (monthStart > dayNumber) {
    monthStart = getNewMoonDay(k, timeZone);

    a11 = getLunarMonth11(yy, timeZone);
    b11 = a11;
    if (a11 >= monthStart) {
      lunarYear = yy;
      a11 = getLunarMonth11(yy - 1, timeZone);
    } else {
      lunarYear = yy + 1;
      b11 = getLunarMonth11(yy + 1, timeZone);
    }
    lunarDay = dayNumber - monthStart + 1;
    diff = (monthStart - a11) ~/ 29;
    lunarLeap = 0;
    lunarMonth = diff + 11;
  }
  if (b11 - a11 > 365) {
    leapMonthDiff = getLeapMonthOffset(a11, timeZone);
    if (diff >= leapMonthDiff) {
      lunarMonth = diff + 10;
      if (diff == leapMonthDiff) {
        lunarLeap = 1;
      }
    }
  }
  if (lunarMonth > 12) {
    lunarMonth = lunarMonth - 12;
  }
  if (lunarMonth >= 11 && diff < 4) {
    lunarYear -= 1;
  }
  return DateTime.utc(lunarYear, lunarMonth, lunarDay);
}

String convertTime(String format, int time, bool isUTC) {
  return DateFormat(format, 'vi')
      .format(DateTime.fromMillisecondsSinceEpoch(time, isUtc: isUTC));
}

List<Point> getStartingPoints(List<RouteEntity> routes) {
  final List<Point> result = <Point>[];
  final List<RouteEntity> routesList = List<RouteEntity>.from(routes);
  for (final RouteEntity routeEntity in routesList) {
    result.addAll(routeEntity.listPoint);
  }
  return result;
}

Map<String, List<Point>> categorizePoints(List<Point> points) {
  final Map<String, List<Point>> result = <String, List<Point>>{};
//  final Map<String, List<String>> temp = <String, List<String>>{};
  for (final Point point in points) {
    result[point.province] = <Point>[];
//    temp[point.province] = <String>[];
  }
  for (final Point point in points) {
    if (result[point.province].isEmpty) {
      result[point.province].add(point);
//      temp[point.province].add(point.name);
    } else {
//      if(temp[point.province].contains(point.name)){
      if (containsPoint(point, result[point.province])) {
        continue;
      } else {
        result[point.province].add(point);
//        temp[point.province].add(point.name);
      }
    }
  }
//  print(result.keys.length);
//  print(temp);
//  print(result);
  return result;
}

bool containsPoint(
  Point point,
  List<Point> points,
) {
  for (final Point element in points) {
    if (point.id == element.id) {
      return true;
    }
  }
  return false;
}

int indexOfPoint(Point point, List<Point> points){
  int i =0;
  while(i<points.length){
    if(points[i].id.trim()==point.id.trim()){
      return i;
    }
    i++;
  }
  return -1;
}

List<Point> getDropOffPoints(Point startPoint, List<RouteEntity> routes) {
  final List<Point> result = <Point>[];
  for (int i =  0; i< routes.length; i++) {
    final RouteEntity routeEntity = routes[i];
    final int index = indexOfPoint(startPoint,routeEntity.listPoint);
    if(index!=-1&&!containsPoint(routeEntity.listPoint[index], result)&&index!=routeEntity.listPoint.length){
      result.addAll(routeEntity.listPoint.getRange(index+1, routeEntity.listPoint.length));
    }
  }
  return result;
}
List<Point> getPossibleStartPoints(Point endPoint, List<RouteEntity> routes){
  final List<Point> result = <Point>[];
  for(int i =0; i< routes.length;i++){
    final RouteEntity routeEntity = routes[i];
    final int index = indexOfPoint(endPoint,routeEntity.listPoint);
    if(index!=-1&&!containsPoint(routeEntity.listPoint[index], result)&&index!=0){
      result.addAll(routeEntity.listPoint.getRange(0,index));
    }
  }
  return result;
}

void printPoint(Point point){
  print('${point.name}:${point.id}');
}
String currencyFormat(int param, String unit) {
  final NumberFormat formatCurrency = NumberFormat();
  String result = formatCurrency.format(param);
  result = result.replaceAll(',', '.');
  return result + unit;
}