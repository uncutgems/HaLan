import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/page/buses_list/filter/trip_filter_bloc.dart';
import 'package:halan/widget/buses_list_filter/buses_list_filter.dart';

class TripFilterWidget extends StatefulWidget {
  const TripFilterWidget({Key key, @required this.onSort}) : super(key: key);
  final ValueChanged<List<bool>> onSort;

  @override
  _TripFilterWidgetState createState() => _TripFilterWidgetState();
}

class _TripFilterWidgetState extends State<TripFilterWidget> {
  final TripFilterBloc bloc = TripFilterBloc();

//  final Key timeKey = const Key('time');
//  final Key priceKey = const Key('price');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripFilterBloc, TripFilterState>(
      cubit: bloc,
      builder: (BuildContext context, TripFilterState state) {
        if (state is TripFilterInitial) {
          return _body(context, state);
        } else
          return Container();
      },
      buildWhen: (TripFilterState prev, TripFilterState current) {
        if (current is CallBackTripFilterState) {
          widget.onSort(<bool>[current.timeSort, current.priceSort]);
          return false;
        } else
          return true;
      },
    );
  }

  Widget _body(BuildContext context, TripFilterInitial state) {
    return Row(
      children: <Widget>[
        FlatButton(
//          key: timeKey,
          child: Row(
            children: <Widget>[
              Text(
                'Thời gian khởi hành',
                style: textTheme.bodyText2.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: state.timeSort == true
                        ? HaLanColor.primaryColor
                        : HaLanColor.gray80),
              ),
              Icon(Icons.arrow_upward,
                  size: 16,
                  color: state.timeSort == true
                      ? HaLanColor.primaryColor
                      : HaLanColor.gray80)
            ],
          ),
          onPressed: () {
            bloc.add(SortTripByTimeFilterEvent(state.timeSort));
//            busListBloc.add(SortListGetDataBusListEvent(true));
          },
        ),
        FlatButton(
//          key: priceKey,
          child: Row(
            children: <Widget>[
              Text('Giá vé',
                  style: textTheme.bodyText2.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: state.priceSort == true
                          ? HaLanColor.primaryColor
                          : HaLanColor.gray80)),
              Icon(Icons.arrow_upward,
                  size: 16,
                  color: state.priceSort == true
                      ? HaLanColor.primaryColor
                      : HaLanColor.gray80)
            ],
          ),
          onPressed: () {
            bloc.add(SortTripByPriceFilterEvent(state.priceSort));
//            busListBloc.add(SortListGetDataBusListEvent(false));
          },
        ),
        Expanded(child: Container()),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            showModalBottomSheet<dynamic>(
                isScrollControlled: false,
                context: context,
                builder: (BuildContext context) => BusesListFilter());
          },
        ),
      ],
    );
  }
}
