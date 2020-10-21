import 'package:avwidget/popup_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';

import 'package:halan/base/styles.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/buses_list/bus_list_bloc.dart';
import 'package:halan/page/buses_list/bus_list_item/bus_list_item_view.dart';
import 'package:halan/widget/fail_widget.dart';

class BusesListWidget extends StatefulWidget {
  const BusesListWidget(
      {Key key, this.onStart, this.onStop, this.startPoint, this.endPoint})
      : super(key: key);
  final VoidCallback onStart;
  final VoidCallback onStop;
  final Point startPoint;
  final Point endPoint;

  @override
  _BusesListWidgetState createState() => _BusesListWidgetState();
}

class _BusesListWidgetState extends State<BusesListWidget> {
  BusListBloc bloc;
  ScrollController tripController;
  int listViewItem = 0;
  int newListView = 0;

  @override
  void initState() {
    bloc = BlocProvider.of<BusListBloc>(context);

//    tripController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusListBloc, BusListState>(
      cubit: bloc,
      builder: (BuildContext context, BusListState state) {
        if (state is SuccessGetDataBusListState) {
          if (state.page == -1) {
            widget.onStart();
            return _body(context, state);
          } else {
            widget.onStop();
            return _body(context, state);
          }
        } else if (state is FailGetDataBusListState) {
          return Scaffold(
            body: Center(
                child: FailWidget(
              message: state.error,
              onPressed: () {
                bloc.add(GetDataBusListEvent());
              },
            )),
          );
        }
        return Container();
      },
    );
  }

  Widget _body(BuildContext context, SuccessGetDataBusListState state) {
    newListView = state.listTrip.length;
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: state.listTrip.isEmpty && state.page != -1
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/no_trip.png'),
                    Text(
                      'Hiện không có chuyến nào ở tuyến đường này! \n Vui lòng chọn tuyến đường hoặc ngày khác',
                      style: textTheme.bodyText1
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                    )
                  ],
                ),
              ),
            )
          : state.listTrip.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == state.listTrip.length &&
                        state.listTrip.length > 6 &&
                        listViewItem < state.listTrip.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                            child: CircularProgressIndicator(
                          backgroundColor: HaLanColor.primaryColor,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(HaLanColor.white),
                        )),
                      );
                    } else {
                      if (index < state.listTrip.length) {
                        final Trip trip = state.listTrip[index];
                        return BusListItemWidget(
                          trip: trip,
                        );
                      } else
                        return Container();
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                        height: 8,
                      ),
                  itemCount: state.listTrip.length + 1)
              : const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: HaLanColor.primaryColor,
                    valueColor: AlwaysStoppedAnimation<Color>(HaLanColor.white),
                  )),
                ),
    );
  }

  void showLoading(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) => const AVLoadingWidget(
              color: HaLanColor.white,
            ));
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.pixels >
          notification.metrics.maxScrollExtent * 0.8) {
        if (listViewItem < newListView) {
          listViewItem = newListView;
          bloc.add(LoadMoreBusListEvent());
        }
      }
    }
    return false;
  }
}
