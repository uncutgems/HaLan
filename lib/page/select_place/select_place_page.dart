import 'package:avwidget/popup_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/size.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/select_place/select_place_bloc.dart';
import 'package:halan/widget/fail_widget.dart';

class SelectPlacePage extends StatefulWidget {
  @override
  _SelectPlacePageState createState() => _SelectPlacePageState();
}

class _SelectPlacePageState extends State<SelectPlacePage> {
  SelectPlaceBloc bloc = SelectPlaceBloc();
  int scenario = 0;
  List<Point> points = <Point>[];
  List<RouteEntity> routes = <RouteEntity>[];
  List<Point> possibleDropOff = <Point>[];
  List<Point> possibleStartPoint = <Point>[];
  Point start;
  Point end;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    bloc.add(SelectPlaceEventGetData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectPlaceBloc, SelectPlaceState>(
      cubit: bloc,
      buildWhen: (SelectPlaceState prev, SelectPlaceState state) {
        if (state is SelectPlaceStateLoading) {
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return const AVLoadingWidget();
              });
          return false;
        } else if (state is SelectPlaceStateDismissLoading) {
          Navigator.pop(context);
          return false;
        } else if (state is SelectPlaceStateFail) {}
        return true;
      },
      builder: (BuildContext context, SelectPlaceState state) {
        if (state is SelectPlaceInitial) {
          return mainView(context,points);
        } else if (state is SelectPlaceStateShowData) {
          routes = state.routes;
          points = state.points;
          return mainView(context,points);
        } else if (state is SelectPlaceStateInitiateScenario) {
          scenario = state.scenario;
          return mainView(context,points);
        } else if (state is SelectPlaceStateFail) {
          return Scaffold(
              backgroundColor: HaLanColor.backgroundColor,
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                backgroundColor: HaLanColor.backgroundColor,
                title: Text(
                  'Chọn địa điểm',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: AppSize.getFontSize(context, 18),
                      color: HaLanColor.black),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: HaLanColor.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Center(
                child: FailWidget(
                  message: state.error,
                  onPressed: () {
                    bloc.add(SelectPlaceEventGetData());
                  },
                ),
              ));
        }
        else if (state is SelectPlaceStateShowStartPoint){
          start = state.startPoint;
          return mainView(context,state.points);
        }
        else if (state is SelectPlaceStateShowDropOffPoint){
          end = state.dropOffPoint;
          return mainView(context, state.points);
        }
        return Container();
      },
    );
  }

  Widget mainView(BuildContext context, List<Point> points) {
    return Scaffold(
      backgroundColor: HaLanColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: HaLanColor.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Chọn địa điểm',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(fontSize: AppSize.getFontSize(context, 18)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: HaLanColor.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSize.getWidth(context, 16)),
        children: <Widget>[
          _searchBox(
              context: context,
              title: 'Điểm khởi hành',
              content: start==null?'Chọn điểm khởi hành':start.name,
              color: scenario == 1 ? HaLanColor.primaryColor : null,
              onTap: scenario!=1?() {
                start=null;
                bloc.add(SelectPlaceEventChooseScenario(1, points));
              }:null),

          Container(height: AppSize.getWidth(context, 8)),
          _searchBox(
              context: context,
              title: 'Điểm đến',
              content: end==null?'Chọn điểm đến':end.name,
              color: scenario == 2 ? HaLanColor.primaryColor : null,
              onTap: scenario!=2?() {
                end = null;
                bloc.add(SelectPlaceEventChooseScenario(2, points));
              }:null),
          Container(
            height: AppSize.getWidth(context, 24),
          ),
          Text(
            'Chọn các điểm có sẵn',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: AppSize.getFontSize(context, 14),
                fontWeight: FontWeight.w500),
          ),
          Container(
            height: AppSize.getWidth(context, 16),
          ),
          if (points.isNotEmpty)
            ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: provinceExpansionTile(context, points))
        ],
      ),
    );
  }

  Widget _searchBox({
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

  List<Widget> provinceExpansionTile(BuildContext context, List<Point> points) {
    final List<Widget> result = <Widget>[];

    final Map<String, List<Point>> provincePoints = categorizePoints(points);

    for (final String province in provincePoints.keys) {
      result.add(Padding(
        padding: EdgeInsets.only(bottom: AppSize.getWidth(context, 8)),
        child: Material(
          color: HaLanColor.white,
          borderRadius: BorderRadius.circular(AppSize.getWidth(context, 8)),
          child: ExpansionTile(
            backgroundColor: HaLanColor.white,
            title: Row(
              children: <Widget>[
                const Icon(
                  Icons.location_on,
                  color: HaLanColor.iconColor,
                ),
                Container(
                  width: AppSize.getWidth(context, 13),
                ),
                Text(
                  province,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: AppSize.getFontSize(context, 12),
                      color: HaLanColor.textColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            children: pointWidgets(context, provincePoints[province]),
          ),
        ),
      ));
    }
    return result;
  }

  List<Widget> pointWidgets(BuildContext context, List<Point> pointList) {
    final List<Widget> result = <Widget>[];
    for (final Point point in pointList) {
      result.add(GestureDetector(
        onTap: (){
          if (scenario==1){
            scenario = 2;
            bloc.add(SelectPlaceEventChooseStartPoint(1,getDropOffPoints(point,routes),point));
          }
          else if(scenario==2){
            scenario=1;
            bloc.add(SelectPlaceEventChooseEndPoint(2,getPossibleStartPoints(point,routes),point));
          }
        },
        child: Padding(
          padding: EdgeInsets.only(
              left: AppSize.getWidth(context, 13),
              bottom: AppSize.getWidth(context, 22)),
          child: Row(
            children: <Widget>[
              ImageIcon(
                const AssetImage('assets/place.png'),
                size: AppSize.getWidth(context, 18),
              ),
              Container(
                width: AppSize.getWidth(context, 13),
              ),
              Text(
                point.name,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: AppSize.getFontSize(context, 12),
                    color: HaLanColor.textColor,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ));
    }
    return result;
  }
}
