import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/avwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/size.dart';
import 'package:halan/base/tool.dart';
 import 'package:halan/model/entity.dart';
import 'package:halan/page/bus_booking/bus_booking_bloc.dart';
import 'package:halan/widget/pop_up_widget/pop_up.dart';
import 'package:halan/widget/popular_route_widget/popular_route.dart';

class BusBookingPage extends StatefulWidget {
  @override
  _BusBookingPageState createState() => _BusBookingPageState();
}

class _BusBookingPageState extends State<BusBookingPage> {
  List<Point> selectedPoints = <Point>[];
  DateTime dateTime=DateTime.now();
  BusBookingBloc bloc = BusBookingBloc();
  final RoundedRectangleBorder border = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
  );

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BusBookingBloc,BusBookingState>(
      cubit: bloc,
      builder: (BuildContext context, BusBookingState state){
        if (state is DisplayDataBusBookingState){
          return mainView(context,selectedPoints,dateTime);
        }
        return  Container();
      },
    );
  }


  Widget mainView(BuildContext context,List<Point> points, DateTime chosenDate){
    return Scaffold(
      backgroundColor: AVColor.halanBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AVColor.gray100),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text('Đặt vé xe',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: AVColor.gray100)
                .copyWith(fontSize: AppSize.getFontSize(context, 18))
                .copyWith(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: AVColor.halanBackground,
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  icon: SvgPicture.asset(
                    'assets/bell.svg',
                    height: AppSize.getWidth(context, 19),
                    width: AppSize.getWidth(context, 16),
                  ),
                  onPressed: () {}),
              Container(
                width: AppSize.getWidth(context, 8),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: AppSize.getHeight(context, 8),
          ),
          mainScreen(context,points,chosenDate),
          Container(
            height: AppSize.getHeight(context, 16),
          ),
          PopUpWidget(),
          PopularRoute(),
        ],
      ),
    );
  }

  Widget mainScreen(BuildContext context,List<Point> points, DateTime chosenDate) {
    return Padding(
      padding: EdgeInsets.only(
          left: AppSize.getWidth(context, 16),
          right: AppSize.getWidth(context, 16)),
      child: Column(
        children: <Widget>[
          pickLocation(
              context,1,
              const Icon(
                Icons.location_on,
                color: HaLanColor.gray80,
                size: 25,
              ),
              'Điểm khởi hành', () async{
            selectedPoints = await Navigator.pushNamed(context, RoutesName.selectPlacePage,
                arguments: <String, dynamic>{Constant.scenario: 1}) as List<Point>;
            bloc.add(GetDataBusBookingEvent(dateTime,selectedPoints));

          },points,chosenDate),
          Container(
            height: AppSize.getWidth(context, 16),
          ),
          pickLocation(
              context,2,
              const Icon(
                Icons.location_on,
                color: HaLanColor.gray80,
                size: 25,
              ),
              'Điểm đến', () async{
            selectedPoints = await Navigator.pushNamed(context, RoutesName.selectPlacePage,
                arguments: <String, dynamic>{Constant.scenario: 2}) as List<Point>;
            print('++++++++++++++++++++++++++++++');
            print(selectedPoints.first.name);
            bloc.add(GetDataBusBookingEvent(dateTime,selectedPoints));
          },points,chosenDate),
          Container(
            height: AppSize.getWidth(context, 16),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: pickLocation(
                    context,
                    3,
                    const Icon(
                      Icons.calendar_today,
                      color: HaLanColor.gray80,
                      size: 25,
                    ),
                    'Ngày khởi hành',
                    () async{
                      dateTime = await Navigator.pushNamed(context, RoutesName.calendarPage,arguments:<String,dynamic>{
                        Constant.dateTime: DateTime.now()
                      } ) as DateTime;
                      print('----------------------');
                      print(dateTime.day);
                      bloc.add(GetDataBusBookingEvent(dateTime,selectedPoints));
                    },points,chosenDate),
              ),
              Container(
                width: AppSize.getWidth(context, 16),
              ),
              Expanded(
                child: AVButton(
                  color: HaLanColor.primaryColor,
                  height: AppSize.getHeight(context, 40),
                  title: 'Tìm chuyến xe',
                  trailingIcon: const Icon(
                    Icons.search,
                    size: 25,
                    color: HaLanColor.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.busesListPage,arguments: <String,dynamic>{
                      Constant.startPoint: selectedPoints.first,
                      Constant.endPoint: selectedPoints.last,
                      Constant.dateTime: dateTime
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget pickLocation(
    BuildContext context,
    int type,
    Widget icon,
    String title,
    VoidCallback onTap,
      List<Point> points,
      DateTime chosenDate
  ) {
    String text = '';
    if(type==1){
      if(points.isNotEmpty){
        text = points.first.name;
      }
      else{
        text='Chọn điểm khởi hành';
      }
    }
    else if(type==2){
      if(points.isNotEmpty){
        text = points.last.name;
      }
      else{
        text='Chọn điểm đón';
      }
    }
    else if(type==3){
        text = convertTime('dd/MM/yyyy', dateTime.millisecondsSinceEpoch, false);
    }
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 2,
        shape: border,
        child: Container(
          height: AppSize.getHeight(context, 40),
          decoration: BoxDecoration(
            color: AVColor.white,
            borderRadius: BorderRadius.circular(AppSize.getWidth(context, 8)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: AppSize.getWidth(context, 13),
              ),
              icon ??
                  const Icon(
                    Icons.location_on,
                    color: HaLanColor.gray80,
                    size: 30,
                  ),
              Container(
                width: AppSize.getWidth(context, 13),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: HaLanColor.disableColor)
                        .copyWith(fontSize: AppSize.getFontSize(context, 12))
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: AppSize.getWidth(context, 4),
                  ),
                  Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: HaLanColor.black)
                        .copyWith(fontSize: AppSize.getFontSize(context, 12))
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
