import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/ticket_confirm/seat_number/seat_number_bloc.dart';

class SeatNumberWidget extends StatefulWidget {
  const SeatNumberWidget({Key key, this.onSeatChanged, this.trip})
      : super(key: key);
  final ValueChanged<int> onSeatChanged;
  final Trip trip;

  @override
  _SeatNumberWidgetState createState() => _SeatNumberWidgetState();
}

class _SeatNumberWidgetState extends State<SeatNumberWidget> {
  final SeatNumberBloc bloc = SeatNumberBloc();

  @override
  void initState() {
    bloc.add(GetDataSeatNumberEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatNumberBloc, SeatNumberState>(
      cubit: bloc,
      builder: (BuildContext context, SeatNumberState state) {
        if (state is SeatNumberInitial) {
          return _body(context, state);
        } else
          return Container();
      },
      buildWhen: (SeatNumberState prev, SeatNumberState current) {
        if (current is CallBackSeatNumberState) {
          widget.onSeatChanged(current.seatNumber);
          return false;
        } else
          return true;
      },
    );
  }

  Widget _body(BuildContext context, SeatNumberInitial state) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Số ghế',
              style: textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: AVSize.getSize(context, 14)),
            ),
            Container(
              height: AVSize.getSize(context, 8),
            ),
            Text(
              'Còn ${widget.trip.totalEmptySeat - state.seatNumber} ghế trống',
              style: textTheme.bodyText2.copyWith(
                  fontSize: AVSize.getFontSize(context, 12),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Expanded(child: Container()),
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                bloc.add(MinusSeatNumberEvent(state.seatNumber));
              },
              child: Container(
                height: AVSize.getSize(context, 40),
                width: AVSize.getSize(context, 40),
                child: const Icon(
                  Icons.remove,
                  color: HaLanColor.disableColor,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HaLanColor.white,
                    border: Border.all(color: HaLanColor.borderColor)),
              ),
            ),
            Container(
              width: AVSize.getSize(context, 8),
            ),
            Container(
              width: AVSize.getSize(context, 56),
              height: AVSize.getSize(context, 40),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: HaLanColor.white,
                  border: Border.all(color: HaLanColor.borderColor, width: 1)),
              child: Center(
                child: Text(
                  state.seatNumber.toString(),
                  style: textTheme.subtitle1.copyWith(
                      fontSize: AVSize.getFontSize(context, 24),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              width: AVSize.getSize(context, 8),
            ),
            GestureDetector(
              onTap: () {
                if (widget.trip.totalEmptySeat - state.seatNumber > 0) {
                  bloc.add(AddSeatNumberEvent(state.seatNumber));
                }
              },
              child: Container(
                height: AVSize.getSize(context, 40),
                width: AVSize.getSize(context, 40),
                child: const Icon(
                  Icons.add,
                  color: HaLanColor.primaryColor,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HaLanColor.white,
                    border: Border.all(color: HaLanColor.primaryColor)),
              ),
            ),
          ],
        )
      ],
    );
  }
}
