import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/avwidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/size.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/model/enum.dart';
import 'package:intl/intl.dart';
import 'package:halan/main.dart';
// chuyển thời gian từ millisecond sang định dạng format
String convertTime(String format, int time, bool isUTC) {
  return DateFormat(format, 'vi')
      .format(DateTime.fromMillisecondsSinceEpoch(time, isUtc: isUTC));
}

int convertNewDayStyleToMillisecond(int time) {
  final String timeString = time.toString();
  final int year = int.parse(timeString.substring(0, 4));
  final int month = int.parse(timeString.substring(4, 6));
  final int day = int.parse(timeString.substring(6, 8));
  return DateTime(year, month, day).millisecondsSinceEpoch;
}

String currencyFormat(int param, String unit) {
  final NumberFormat formatCurrency = NumberFormat();
  final String result = formatCurrency.format(param);
  return result + ' ' + unit;
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
        text:
            currencyFormat(int.parse(newValue.text.toString().trim()), 'VNĐ'));
  }
}

void showMessage(
    {@required BuildContext context,
    @required String message,
    List<Widget> actions}) {
  actions ??= <Widget>[];
  actions.add(AVButton(color: HaLanColor.primaryColor,title: 'Đóng', onPressed: () => Navigator.pop(context)));
  showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Thông báo'),
        content: Text(message),
        actions: actions,
      );
    },
  );
}

List<String> source = <String>[
  'À',
  'Á',
  'Â',
  'Ã',
  'È',
  'É',
  'Ê',
  'Ì',
  'Í',
  'Ò',
  'Ó',
  'Ô',
  'Õ',
  'Ù',
  'Ú',
  'Ý',
  'à',
  'á',
  'â',
  'ã',
  'è',
  'é',
  'ê',
  'ì',
  'í',
  'ò',
  'ó',
  'ô',
  'õ',
  'ù',
  'ú',
  'ý',
  'Ă',
  'ă',
  'Đ',
  'đ',
  'Ĩ',
  'ĩ',
  'Ũ',
  'ũ',
  'Ơ',
  'ơ',
  'Ư',
  'ư',
  'Ạ',
  'ạ',
  'Ả',
  'ả',
  'Ấ',
  'ấ',
  'Ầ',
  'ầ',
  'Ẩ',
  'ẩ',
  'Ẫ',
  'ẫ',
  'Ậ',
  'ậ',
  'Ắ',
  'ắ',
  'Ằ',
  'ằ',
  'Ẳ',
  'ẳ',
  'Ẵ',
  'ẵ',
  'Ặ',
  'ặ',
  'Ẹ',
  'ẹ',
  'Ẻ',
  'ẻ',
  'Ẽ',
  'ẽ',
  'Ế',
  'ế',
  'Ề',
  'ề',
  'Ể',
  'ể',
  'Ễ',
  'ễ',
  'Ệ',
  'ệ',
  'Ỉ',
  'ỉ',
  'Ị',
  'ị',
  'Ọ',
  'ọ',
  'Ỏ',
  'ỏ',
  'Ố',
  'ố',
  'Ồ',
  'ồ',
  'Ổ',
  'ổ',
  'Ỗ',
  'ỗ',
  'Ộ',
  'ộ',
  'Ớ',
  'ớ',
  'Ờ',
  'ờ',
  'Ở',
  'ở',
  'Ỡ',
  'ỡ',
  'Ợ',
  'ợ',
  'Ụ',
  'ụ',
  'Ủ',
  'ủ',
  'Ứ',
  'ứ',
  'Ừ',
  'ừ',
  'Ử',
  'ử',
  'Ữ',
  'ữ',
  'Ự',
  'ự'
];
List<String> destination = <String>[
  'A',
  'A',
  'A',
  'A',
  'E',
  'E',
  'E',
  'I',
  'I',
  'O',
  'O',
  'O',
  'O',
  'U',
  'U',
  'Y',
  'a',
  'a',
  'a',
  'a',
  'e',
  'e',
  'e',
  'i',
  'i',
  'o',
  'o',
  'o',
  'o',
  'u',
  'u',
  'y',
  'A',
  'a',
  'D',
  'd',
  'I',
  'i',
  'U',
  'u',
  'O',
  'o',
  'U',
  'u',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'E',
  'e',
  'E',
  'e',
  'E',
  'e',
  'E',
  'e',
  'E',
  'e',
  'E',
  'e',
  'E',
  'e',
  'E',
  'e',
  'I',
  'i',
  'I',
  'i',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'U',
  'u',
  'U',
  'u',
  'U',
  'u',
  'U',
  'u',
  'U',
  'u',
  'U',
  'u',
  'U',
  'u'
];

double radians(double deg) {
  return deg * (pi / 180);
}

double distance(
    double startLat, double startLng, double endLat, double endLng) {
  const double R = 6371;
  final double dLat = radians(endLat - startLat);
  final double dLng = radians(endLng - startLng);
  final double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(radians(startLat)) *
          cos(radians(endLat)) *
          sin(dLng / 2) *
          sin(dLng / 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final double d = R * c;
  return d;
}

String convertAccent(String text) {
  String result = '';
  for (int i = 0; i < text.length; i++) {
    final int index = source.indexOf(text[i]);
    if (index != -1) {
      result += destination[index];
    } else {
      result += text[i];
    }
  }
  return result;
}

String setTitleByTicketStatus(Ticket ticket) {
  switch (ticket.ticketStatus) {
//  static const int invalid = -2;
//  static const int canceled = 0;
//  static const int empty = 1;
//  static const int booked = 2;
//  static const int bought = 3;
//  static const int onTheTrip = 4;
//  static const int completed = 5;
//  static const int overTime = 6;
//  static const int bookedAdmin = 7;
    case TicketStatus.empty:
      return 'Chưa đặt';
      break;
    case TicketStatus.booked:
      return 'Đã giữ chỗ';

      break;
    case TicketStatus.bought:
      return 'Đã mua vé';
      break;
    case TicketStatus.onTheTrip:
      return 'Đã lên xe';
      break;
    case TicketStatus.completed:
      return 'Đã hoàn thành';
      break;
    case TicketStatus.bookedAdmin:
      return 'Đã giữ chỗ';
      break;
      case TicketStatus.canceled:
      return 'Đã hủy';
      break;
  }
  return 'Vé đang xử lý';
}

Color setColorByTicketStatus(Ticket ticket) {
  switch (ticket.ticketStatus) {
    case TicketStatus.empty:
      return HaLanColor.primaryColor;
      break;
    case TicketStatus.booked:
      return HaLanColor.primaryColor;

      break;
    case TicketStatus.canceled:
      return HaLanColor.cancelColor;

      break;
    case TicketStatus.overTime:
      return HaLanColor.cancelColor;

      break;
    case TicketStatus.bought:
      return HaLanColor.green;
      break;
    case TicketStatus.onTheTrip:
      return HaLanColor.green;
      break;
    case TicketStatus.completed:
      return HaLanColor.green;
      break;
    case TicketStatus.bookedAdmin:
      return HaLanColor.primaryColor;
      break;
  }
  return HaLanColor.primaryColor;
}

Widget homeStateTop(BuildContext context,VoidCallback onPressed){
  return  Padding(
    padding: EdgeInsets.all(AppSize.getWidth(context, 16)),
    child: Row(
      children: <Widget>[
        Expanded(
          child: AVButton(
            leadingIcon: SvgPicture.asset(
              'assets/bus.svg',
              height: AppSize.getWidth(context, 16),
              width: AppSize.getWidth(context, 30),
            ),
            title: 'Đặt xe',
            width: AppSize.getWidth(context, 163),
            height: AppSize.getWidth(context, 64),
            color: AVColor.orange100,
            onPressed: onPressed
          ),
        ),
        Container(
          width: AppSize.getWidth(context, 16),
        ),
        Expanded(
          child: AVButton(
            leadingIcon: SvgPicture.asset(
              'assets/taxi.svg',
              height: AppSize.getWidth(context, 16),
              width: AppSize.getWidth(context, 30),
            ),
            title: 'Đặt taxi',
            width: AppSize.getWidth(context, 163),
            height: AppSize.getWidth(context, 64),
            color: AVColor.orange100,
            onPressed:(){}
          ),
        ),
      ],
    ),
  );
}
double calculatePrice(Trip trip, List<Seat> selectedSeats,Point pointUp,Point pointDown) {
  double totalPrice = 0;
  final List<RouteEntity> routes = <RouteEntity>[];
  print('tttttttttttttt ${pointUp.listPrice}');
//  print(prefs.get(Constant.routes));
  jsonDecode(prefs.getString(Constant.routes)).forEach((final dynamic itemJson) {
    routes.add(RouteEntity.fromMap(itemJson as Map<String, dynamic>));
  });

//  print(routes);
  RouteEntity trueRoute;
  for(final RouteEntity route in routes){
    if(route.id==trip.route.id){
      print(route.id);
      trueRoute=route;
    }
  }
  print(trueRoute.listPoint.length);

  final int index = indexOfPoint(pointDown, trueRoute.listPoint);
  printPoint(pointDown);
  print('haya $index');

  if(index!=-1){
    totalPrice+=pointUp.listPrice[index]*selectedSeats.length;
//    print('tttttttttttttt ${pointUp.listPrice}');
  }
  print(selectedSeats==null);
  for(final Seat seat in selectedSeats){
    print(seat.seatId);
    totalPrice+=seat.extraPrice;
  }

  return totalPrice;

}


Future<Uint8List> getBytesFromAsset(String path, int width) async {
  final ByteData data = await rootBundle.load(path);
  final ui.Codec codec = await ui
      .instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  final ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      .buffer
      .asUint8List();
}
  double getBearingBetweenTwoPoints1(LatLng latLng1, LatLng latLng2) {

  final double lat1 = degreesToRadians(latLng1.latitude);
  final double long1 = degreesToRadians(latLng1.longitude);
  final double lat2 = degreesToRadians(latLng2.latitude);
  final double long2 = degreesToRadians(latLng2.longitude);


  final double dLon = long2 - long1;


  final double y = sin(dLon) * cos(lat2);
  final double x = cos(lat1) * sin(lat2) - sin(lat1)
      * cos(lat2) * cos(dLon);

  final double radiansBearing = atan2(y, x);

  return radiansToDegrees(radiansBearing);
}
 double degreesToRadians(double degrees) {
  return degrees * pi / 180.0;
}
 double radiansToDegrees(double radians) {
  return radians * 180.0 / pi;
}
Point setUpPointType(String text,Point point,{String homeAddress,Point transshipment}){
  if(text.contains('bến')){
    print('cccc');
    point= point.copyWith(pointType: TransportType.station);
    print(point.pointType);
  }
  else if(text.contains('nhà')){
    point= point.copyWith(pointType: TransportType.home,address:homeAddress??point.address);
  }
  return point;
}
Widget searchBox({
  @required BuildContext context,
  @required String title,
  @required String content,
  @required VoidCallback onTap,
  Color color,
  Widget icon,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 48,
      decoration: BoxDecoration(
        color: HaLanColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Container(width: AppSize.getWidth(context, 8)),
          icon ??
              Icon(
                Icons.location_on,
                color: color ?? HaLanColor.iconColor,
              ),
          Container(width: AppSize.getWidth(context, 8)),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: color ?? HaLanColor.disableColor,fontWeight: FontWeight.w600),
                ),
                Text(content),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
Widget pickLocation(BuildContext context, int type, Widget icon, String title,
    VoidCallback onTap, List<Point> points, DateTime chosenDate) {
  String text = '';
  if (type == 1) {
    if (points.isNotEmpty) {
      text = points.first.name;
    } else {
      text = 'Chọn điểm khởi hành';
    }
  } else if (type == 2) {
    if (points.isNotEmpty) {
      text = points.last.name;
    } else {
      text = 'Chọn điểm đón';
    }
  } else if (type == 3) {
    text = convertTime('dd/MM/yyyy', chosenDate.millisecondsSinceEpoch, false);
  }
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 48,
      decoration: BoxDecoration(
        color: HaLanColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Container(width: AppSize.getWidth(context, 8)),
          icon ??
              const Icon(
                Icons.location_on,
                color: HaLanColor.iconColor,
              ),
          Container(width: AppSize.getWidth(context, 8)),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: HaLanColor.disableColor,
                      fontWeight: FontWeight.w600),
                ),
                Text(text,maxLines: 1,),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}