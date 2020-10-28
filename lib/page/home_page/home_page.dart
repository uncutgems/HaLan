import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/avwidget.dart';
import 'package:avwidget/popup_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/size.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/page/home_page/home_bloc.dart';
import 'package:halan/widget/pop_up_widget/pop_up.dart';
import 'package:halan/widget/popular_route_widget/popular_route.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    homeBloc.add(GetDataHomeEvent());
    super.initState();
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      cubit: homeBloc,
      buildWhen: (HomeState prev, HomeState state) {
        if (state is LoadingHomeState) {
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return const AVLoadingWidget();
              });
          return false;
        } else if (state is DismissLoadingHomeState) {
          Navigator.pop(context);
        }
        return true;
      },
      builder: (BuildContext context, HomeState state) {
        if (state is DisplayDataHomeState) {
          return homeScreen(context, state);
        }
        return Container();
      },
    );
  }

  Widget homeScreen(BuildContext context, DisplayDataHomeState state) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AVColor.halanBackground,
      appBar: AppBar(
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
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: AppSize.getWidth(context, 16)),
            child: Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/bell.svg',
                      height: AppSize.getWidth(context, 25),
                    ),
                    Positioned(
                      right: 0,
                      child: Stack(
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/red_circle.svg',
                            height: AppSize.getWidth(context, 13),
                            width: AppSize.getWidth(context, 13),
                          ),
                          Positioned(
                            top: 2,
                            right: 3,
                            child: Text('24',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: AVColor.white)
                                    .copyWith(
                                        fontSize:
                                            AppSize.getFontSize(context, 6))
                                    .copyWith(fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: _drawer(context),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
         homeStateTop(context,(){Navigator.pushNamed(context, RoutesName.busBookingPage);}),
          PopUpWidget(),
          PopularRoute(),
        ],
      ),
    );
  }

  Widget _drawer(BuildContext context) {
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
            AVButton(
              height: AppSize.getHeight(context, 40),
              width: AppSize.getHeight(context, 248),
              title: 'Đăng nhập tài khoản',
              color: AVColor.orange100,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutesName.homeSignInPage);
              },
            ),
            Container(
              height: AppSize.getHeight(context, 16),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context,RoutesName.promotionPage);
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
          ],
        ),
      ),
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