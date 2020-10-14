import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/page/ticket_confirm/payment/ticket_payment_bloc.dart';

class TicketPaymentWidget extends StatefulWidget {

  @override
  _TicketPaymentWidgetState createState() => _TicketPaymentWidgetState();
}

class _TicketPaymentWidgetState extends State<TicketPaymentWidget> {
   TicketPaymentBloc bloc ;
  
  @override
  void initState() {
    bloc=BlocProvider.of<TicketPaymentBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketPaymentBloc, TicketPaymentState>(
      cubit: bloc,
      builder: (BuildContext context, TicketPaymentState state) {
        if (state is TicketPaymentInitial) {
          return _body(context, state);
        } else
          return Container();
      },
    );
  }

  Widget _body(BuildContext context, TicketPaymentInitial state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding:const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: HaLanColor.primaryColor,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(24), bottom: Radius.zero),
          ),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${state.seatNumber} ghế',
                    style: textTheme.subtitle1.copyWith(
                        fontSize: AVSize.getFontSize(context, 14),
                        color: HaLanColor.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    height: AVSize.getSize(context, 10),
                  ),
                  Text(
                    currencyFormat(state.totalPrice.toInt(), 'Đ'),
                    style: textTheme.subtitle1.copyWith(
                        fontSize: AVSize.getFontSize(context, 18),
                        color: HaLanColor.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Expanded(child: Container()),
              AVButton(
                onPressed: () {
                  print('hi');
                },
                color: HaLanColor.white,
                title: 'Xác nhận đặt',
                textColor: HaLanColor.primaryColor,
                trailingIcon: const Icon(Icons.arrow_forward, color: HaLanColor.primaryColor,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
