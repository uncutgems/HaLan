import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/avwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/size.dart';
import 'package:halan/widget/pop_up_widget/pop_up.dart';
import 'package:halan/widget/popular_route_widget/popular_route.dart';

class BusBookingPage extends StatefulWidget {
  @override
  _BusBookingPageState createState() => _BusBookingPageState();
}

class _BusBookingPageState extends State<BusBookingPage> {
  final RoundedRectangleBorder border = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
  );

  @override
  Widget build(BuildContext context) {
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
          mainScreen(context),
          Container(
            height: AppSize.getHeight(context, 16),
          ),
          PopUpWidget(),
          PopularRoute(),
        ],
      ),
    );
  }

  Widget mainScreen(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: AppSize.getWidth(context, 16),
          right: AppSize.getWidth(context, 16)),
      child: Column(
        children: <Widget>[
          pickLocation(
              context,
              const Icon(
                Icons.location_on,
                color: HaLanColor.gray80,
                size: 25,
              ),
              'Điểm khởi hành'),
          Container(
            height: AppSize.getWidth(context, 16),
          ),
          pickLocation(
              context,
              const Icon(
                Icons.location_on,
                color: HaLanColor.gray80,
                size: 25,
              ),
              'Điểm đến'),
          Container(
            height: AppSize.getWidth(context, 16),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: pickLocation(
                    context,
                    const Icon(
                      Icons.calendar_today,
                      color: HaLanColor.gray80,
                      size: 25,
                    ),
                    'Ngày khởi hành'),
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
                  onPressed: () {},
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
    Widget icon,
    String title,
  ) {
    return GestureDetector(
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
                        .copyWith(color: HaLanColor.gray50)
                        .copyWith(fontSize: AppSize.getFontSize(context, 12))
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: AppSize.getWidth(context, 4),
                  ),
                  Text(
                    'Hà Nội',
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
