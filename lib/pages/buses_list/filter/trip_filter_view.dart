import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/pages/buses_list/filter/trip_filter_bloc.dart';

class TripFilterWidget extends StatefulWidget {
  const TripFilterWidget({Key key, @required this.onSort}) : super(key: key);
  final ValueChanged<Key> onSort;

  @override
  _TripFilterWidgetState createState() => _TripFilterWidgetState();
}

class _TripFilterWidgetState extends State<TripFilterWidget> {
  final TripFilterBloc bloc = TripFilterBloc();
  final Key timeKey = const Key('time');
  final Key priceKey = const Key('price');

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
          widget.onSort(current.key);
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
          key: timeKey,
          child: Row(
            children: <Widget>[
              Text(
                'Thời gian khởi hành',
                style: textTheme.bodyText2.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: state.selectedButton == timeKey
                        ? HaLanColor.primaryColor
                        : HaLanColor.gray80),
              ),
              Icon(Icons.arrow_upward,
                  size: 16,
                  color: state.selectedButton == timeKey
                      ? HaLanColor.primaryColor
                      : HaLanColor.gray80)
            ],
          ),
          onPressed: () {
            bloc.add(SortTripFilterEvent(timeKey));
//            busListBloc.add(SortListGetDataBusListEvent(true));
          },
        ),
        FlatButton(
          key: priceKey,
          child: Row(
            children: <Widget>[
              Text('Giá vé',
                  style: textTheme.bodyText2.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: state.selectedButton == priceKey
                          ? HaLanColor.primaryColor
                          : HaLanColor.gray80)),
              Icon(Icons.arrow_upward,
                  size: 16,
                  color: state.selectedButton == priceKey
                      ? HaLanColor.primaryColor
                      : HaLanColor.gray80)
            ],
          ),
          onPressed: () {
            bloc.add(SortTripFilterEvent(priceKey));
//            busListBloc.add(SortListGetDataBusListEvent(false));
          },
        ),
        Expanded(child: Container()),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            print('filter page');
          },
        ),
      ],
    );
  }
}
