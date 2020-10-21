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
import 'package:halan/widget/popular_route_widget/popular_route_bloc.dart';

class PopularRoute extends StatefulWidget {
  @override
  _PopularRouteState createState() => _PopularRouteState();
}

class _PopularRouteState extends State<PopularRoute> {
  final RoundedRectangleBorder border = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    ),
  );
  final RoundedRectangleBorder listTileBorder = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
  );
  PopularRouteBloc popularRouteBloc = PopularRouteBloc();

  @override
  void initState() {
    popularRouteBloc.add(GetPopularPopularRouteEvent());
    super.initState();
  }

  @override
  void dispose() {
    popularRouteBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: border,
      color: HaLanColor.primaryColor,
      child: Column(
        children: <Widget>[
          Container(height: AppSize.getHeight(context, 15)),
          SvgPicture.asset(
            'assets/rectangle.svg',
            height: AppSize.getWidth(context, 4),
            width: AppSize.getWidth(context, 24),
          ),
          Container(height: AppSize.getHeight(context, 16)),
          Container(
            child: Text('Các tuyến phổ biến',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: AVColor.white)
                    .copyWith(fontSize: AppSize.getFontSize(context, 18))
                    .copyWith(fontWeight: FontWeight.w600)),
          ),
          Container(height: AppSize.getHeight(context, 8)),
          BlocBuilder<PopularRouteBloc, PopularRouteState>(
              cubit: popularRouteBloc,
              builder: (BuildContext context, PopularRouteState state) {
                print(state);
                if (state is DisplayPopularRouteState) {
                  if (state.popularRouteList.isEmpty) {
                    return Container(
                      child: Center(
                        child: Text('Không có tuyến phổ biến hiện tại',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: AVColor.gray100)
                                .copyWith(
                                    fontSize: AppSize.getFontSize(context, 18))
                                .copyWith(fontWeight: FontWeight.w600)),
                      ),
                      height: MediaQuery.of(context).size.height * 2 / 3,
                    );
                  }
                  return popularRoutesList(context, state);
                } else if (state is LoadingPopularRouteState) {
                  return Container(
                    child: _loading(context),
                    height: MediaQuery.of(context).size.height * 2 / 3,
                  );
                } else if (state is PopularRouteFailState) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.getWidth(context, 8),
                            horizontal: AppSize.getWidth(context, 16)),
                        child: Container(
                            height: AppSize.getWidth(context, 80),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: HaLanColor.primaryLightColor,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.getWidth(context, 8),
                            horizontal: AppSize.getWidth(context, 16)),
                        child: Container(
                            height: AppSize.getWidth(context, 80),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: HaLanColor.primaryLightColor,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.getWidth(context, 8),
                            horizontal: AppSize.getWidth(context, 16)),
                        child: Container(
                            height: AppSize.getWidth(context, 80),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: HaLanColor.primaryLightColor,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.getWidth(context, 8),
                            horizontal: AppSize.getWidth(context, 16)),
                        child: Container(
                            height: AppSize.getWidth(context, 80),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: HaLanColor.primaryLightColor,
                            )),
                      )
                    ],
                  );
                }
                return Container();
              }),
        ],
      ),
    );
  }

  Widget popularRoutesList(
      BuildContext context, DisplayPopularRouteState state) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.popularRouteList.length,
        itemBuilder: (BuildContext context, int index) {
          final RouteEntity routeEntity = state.popularRouteList[index];
          return popularRoute(context, routeEntity);
        });
  }

  Widget popularRoute(BuildContext context, RouteEntity routeEntity) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSize.getHeight(context, 8),
        bottom: AppSize.getHeight(context, 8),
        right: AppSize.getWidth(context, 16),
        left: AppSize.getWidth(context, 16),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RoutesName.busesListPage,
              arguments: <String, dynamic>{
                Constant.startPoint: routeEntity.listPoint.first,
                Constant.endPoint: routeEntity.listPoint.last,
                Constant.dateTime: DateTime.now()
              });
        },
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/bus_background.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: AppSize.getHeight(context, 0),
                  left: AppSize.getWidth(context, 16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: AppSize.getHeight(context, 18),
                  ),
                  Text(routeEntity.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: AVColor.white)
                          .copyWith(fontSize: AppSize.getFontSize(context, 14))
                          .copyWith(fontWeight: FontWeight.w600)),
                  Container(
                    height: AppSize.getHeight(context, 4),
                  ),
                  Text(
                    '~${routeEntity.distance.toInt()}km',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AVColor.white)
                        .copyWith(fontSize: AppSize.getFontSize(context, 12))
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: AppSize.getHeight(context, 16),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              right: 16,
              child: Text(
                currencyFormat(routeEntity.displayPrice.toInt(), 'đ'),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: AVColor.white)
                    .copyWith(fontSize: AppSize.getFontSize(context, 18))
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
              top: 0,
              right: 16,
              child: (routeEntity.newRoute)
                  ? SvgPicture.asset(
                      'assets/new_label_final.svg',
                      height: AppSize.getWidth(context, 24),
                      width: AppSize.getWidth(context, 41),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loading(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppSize.getHeight(context, 16)),
      child: const Center(
        child: CircularProgressIndicator(
//          valueColor: AlwaysStoppedAnimation<Color>(HaLanColor.primaryColor),
            ),
      ),
    );
  }
}
