import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/avwidget.dart';
import 'package:avwidget/popup_loading_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/size.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/home_page/home_bloc.dart';
import 'package:halan/widget/pop_up_widget/pop_up.dart';
import 'package:halan/widget/popular_route_widget/popular_route.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();

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
      backgroundColor: AVColor.halanBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/myicon.svg',
            height: AppSize.getWidth(context, 12),
            width: AppSize.getWidth(context, 16),
          ),
          onPressed: () {},
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
          ) ,
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(AppSize.getHeight(context, 16)),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: AVButton(
                    leadingIcon: IconButton(
                        icon: SvgPicture.asset(
                          'assets/bus.svg',
                          height: AppSize.getWidth(context, 16),
                          width: AppSize.getWidth(context, 30),
                        ),
                        ),
                    title: 'Đặt xe',
                    width: AppSize.getWidth(context, 163),
                    height: AppSize.getWidth(context, 64),
                    color: AVColor.orange100,
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RoutesName.busBookingPage);
                    },
                  ),
                ),
                Container(
                  width: AppSize.getWidth(context, 16),
                ),
                Expanded(
                  child: AVButton(
                    leadingIcon: IconButton(
                        icon: SvgPicture.asset(
                          'assets/taxi.svg',
                          height: AppSize.getWidth(context, 16),
                          width: AppSize.getWidth(context, 30),
                        ),
                        onPressed: () {}),
                    title: 'Đặt taxi',
                    width: AppSize.getWidth(context, 163),
                    height: AppSize.getWidth(context, 64),
                    color: AVColor.orange100,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          PopUpWidget(),
          PopularRoute(),
        ],
      ),
    );
  }
}
