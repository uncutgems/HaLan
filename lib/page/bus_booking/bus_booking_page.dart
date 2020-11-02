import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/avwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/size.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/bus_booking/bus_booking_bloc.dart';
import 'package:halan/page/promotion_page/promotion_page.dart';
import 'package:halan/widget/pop_up_widget/pop_up.dart';
import 'package:halan/widget/popular_route_widget/popular_route.dart';
import 'package:halan/main.dart';

class BusBookingPage extends StatefulWidget {
  const BusBookingPage({Key key, this.refreshPage}) : super(key: key);
  final bool refreshPage;

  @override
  _BusBookingPageState createState() => _BusBookingPageState();
}

class _BusBookingPageState extends State<BusBookingPage> {
  List<Point> selectedPoints = <Point>[];
  DateTime dateTime = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  BusBookingBloc bloc = BusBookingBloc();
  final RoundedRectangleBorder border = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
  );

  @override
  void initState() {
    prefs.setBool(Constant.haveChoseSeat, false);
    if (widget.refreshPage != null) {
      if (widget.refreshPage == true) {
        bloc.add(ChangeToHomeBusBookingEvent());
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusBookingBloc, BusBookingState>(
      cubit: bloc,
      builder: (BuildContext context, BusBookingState state) {
        if (state is DisplayDataBusBookingState) {
          return mainView(
              context,
              mainScreen(context, selectedPoints, dateTime),
              state,
              busBookingAppBar(context));
        } else if (state is ChangeToHomeBusBookingState) {
          return mainView(
              context,
              homeStateTop(context, () {
                bloc.add(GetDataBusBookingEvent(dateTime, selectedPoints));
              }),
              state,
              homeAppBar(context));
        }
        return Container();
      },
    );
  }

  Widget mainView(BuildContext context, Widget bodyPart, BusBookingState state,
      PreferredSizeWidget appBar) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AVColor.halanBackground,
      appBar: appBar,
      body: ListView(
        children: <Widget>[
          Container(
            height: AppSize.getHeight(context, 8),
          ),
          bodyPart,
          Container(
            height: AppSize.getHeight(context, 16),
          ),
          PopUpWidget(),
          PopularRoute(),
        ],
      ),
      drawer: state is ChangeToHomeBusBookingState ? _drawer(context) : null,
    );
  }

  Widget mainScreen(
      BuildContext context, List<Point> points, DateTime chosenDate) {
    return Padding(
      padding: EdgeInsets.only(
          left: AppSize.getWidth(context, 16),
          right: AppSize.getWidth(context, 16)),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                pickLocation(
                    context,
                    1,
                    const Icon(
                      Icons.location_on,
                      color: HaLanColor.gray80,
                      size: 25,
                    ),
                    'Điểm khởi hành', () async {
                  selectedPoints = await Navigator.pushNamed(
                          context, RoutesName.selectPlacePage,
                          arguments: <String, dynamic>{Constant.scenario: 1})
                      as List<Point>;
                  bloc.add(GetDataBusBookingEvent(dateTime, selectedPoints));
                }, points, chosenDate),
                Container(
                  height: AppSize.getWidth(context, 16),
                ),
                pickLocation(
                    context,
                    2,
                    const Icon(
                      Icons.location_on,
                      color: HaLanColor.gray80,
                      size: 25,
                    ),
                    'Điểm đến', () async {
                  selectedPoints = await Navigator.pushNamed(
                          context, RoutesName.selectPlacePage,
                          arguments: <String, dynamic>{Constant.scenario: 2})
                      as List<Point>;
//                  print('++++++++++++++++++++++++++++++');
//                  print(selectedPoints.first.name);
                  bloc.add(GetDataBusBookingEvent(dateTime, selectedPoints));
                }, points, chosenDate),
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
                          'Ngày khởi hành', () async {
                        dateTime = await Navigator.pushNamed(
                            context, RoutesName.calendarPage,
                            arguments: <String, dynamic>{
                              Constant.dateTime: DateTime.now()
                            }) as DateTime;
                        print('----------------------');
                        print(dateTime.day);
                        bloc.add(
                            GetDataBusBookingEvent(dateTime, selectedPoints));
                      }, points, chosenDate),
                    ),
                    Container(
                      width: AppSize.getWidth(context, 16),
                    ),
                    Expanded(
                      child: AVButton(
                        color: HaLanColor.primaryColor,
                        height: AppSize.getHeight(context, 40),
                        title: 'Tìm chuyến',
                        trailingIcon: const Icon(
                          Icons.search,
                          size: 25,
                          color: HaLanColor.white,
                        ),
                        onPressed: selectedPoints.isNotEmpty
                            ? () {
                                Navigator.pushNamed(
                                    context, RoutesName.busesListPage,
                                    arguments: <String, dynamic>{
                                      Constant.startPoint: selectedPoints.first,
                                      Constant.endPoint: selectedPoints.last,
                                      Constant.dateTime: dateTime
                                    });
//                    bloc.add(ChangeToHomeBusBookingEvent());
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2 -
                      AppSize.getWidth(context, 16),
                  top: AppSize.getWidth(context, 30)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: HaLanColor.blue),
                child: IconButton(
                  icon: const ImageIcon(AssetImage('assets/reverse.png')),
                  onPressed: selectedPoints.isEmpty ? null : () {
                    selectedPoints = <Point>[selectedPoints[1],selectedPoints[0]];
                    bloc.add(GetDataBusBookingEvent(dateTime,selectedPoints));
                  },
                  color: HaLanColor.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget homeAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/myicon.svg',
          height: AppSize.getWidth(context, 12),
          width: AppSize.getWidth(context, 16),
        ),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      elevation: 0,
      backgroundColor: AVColor.halanBackground,
      title: Text(
        'Xe khách Hà Lan',
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: AVColor.gray100)
            .copyWith(fontSize: AppSize.getFontSize(context, 18))
            .copyWith(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
    );
  }

  Widget _drawer(BuildContext context) {
//    print('==========${prefs.getString(Constant.phoneNumber)}');
    Widget login = AVButton(
      height: AppSize.getHeight(context, 40),
      width: AppSize.getHeight(context, 248),
      title: 'Đăng nhập tài khoản',
      color: AVColor.orange100,
      onPressed: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, RoutesName.homeSignInPage);
      },
    );
    if (prefs.getString(Constant.token) != null) {
      login = GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RoutesName.personalProfile);
        },
        child: Container(
          padding: EdgeInsets.all(AppSize.getWidth(context, 8)),
          color: HaLanColor.lightOrange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: AppSize.getWidth(context, 20),
                    backgroundImage:
                        NetworkImage(prefs.getString(Constant.avatar)),
                    backgroundColor: Colors.transparent,
                  ),
                  Container(
                    width: AppSize.getWidth(context, 8),
                  ),
                  Text(
                    prefs.getString(Constant.phoneNumber),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: AppSize.getFontSize(context, 14)),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward,
                color: AVColor.orange100,
              )
            ],
          ),
        ),
      );
    }
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(
            left: AppSize.getWidth(context, 16),
            right: AppSize.getWidth(context, 16)),
        child: Column(
          children: <Widget>[
            Container(
              height: AppSize.getHeight(context, 32),
            ),
            SvgPicture.asset(
              'assets/halan_logo.svg',
              height: AppSize.getWidth(context, 64),
              width: AppSize.getWidth(context, 138),
            ),
            Container(
              height: AppSize.getHeight(context, 13),
            ),
            SvgPicture.asset(
              'assets/separator.svg',
              height: AppSize.getWidth(context, 3),
            ),
            Container(
              height: AppSize.getHeight(context, 16),
            ),
            login,
            Container(
              height: AppSize.getHeight(context, 16),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push<dynamic>(
                    context, SwipeRoute(page: PromotionPage()));
              },
              child: customListTile(
                context,
                'Chương trình khuyến mãi',
                SvgPicture.asset(
                  'assets/promo.svg',
                  height: AppSize.getWidth(context, 23),
                  width: AppSize.getWidth(context, 23),
                  color: AVColor.orange100,
                ),
              ),
            ),
            Container(
              height: AppSize.getHeight(context, 16),
            ),
            customListTile(
              context,
              'Giới thiệu',
              SvgPicture.asset(
                'assets/about_icon.svg',
                height: AppSize.getWidth(context, 23),
                width: AppSize.getWidth(context, 23),
                color: AVColor.orange100,
              ),
            ),
            Container(
              height: AppSize.getHeight(context, 16),
            ),
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/contact.svg',
                  height: AppSize.getWidth(context, 23),
                  width: AppSize.getWidth(context, 23),
                  color: AVColor.orange100,
                ),
                Container(
                  width: AppSize.getWidth(context, 20),
                ),
                Text(
                  'Liên hệ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w600)
                      .copyWith(fontSize: AppSize.getFontSize(context, 12)),
                ),
              ],
            ),
            if (prefs.getString(Constant.token) != null)
              Padding(
                padding: EdgeInsets.only(top: AppSize.getWidth(context, 16)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.historyHomePage);
                  },
                  child: customListTile(
                    context,
                    'Lịch sử',
                    SvgPicture.asset(
                      'assets/promo.svg',
                      height: AppSize.getWidth(context, 23),
                      width: AppSize.getWidth(context, 23),
                      color: AVColor.orange100,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget busBookingAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AVColor.gray100),
        onPressed: () {
          bloc.add(ChangeToHomeBusBookingEvent());
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
    );
  }

  Widget customListTile(BuildContext context, String title, Widget icon) {
    return Row(
      children: <Widget>[
        icon,
        Container(
          width: AppSize.getWidth(context, 16),
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(fontWeight: FontWeight.w600)
              .copyWith(fontSize: AppSize.getFontSize(context, 12)),
        ),
      ],
    );
  }
}
