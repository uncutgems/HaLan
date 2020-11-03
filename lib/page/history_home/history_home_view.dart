import 'package:avwidget/av_alert_dialog_widget.dart';
import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/history_home/history_home_bloc.dart';

class HistoryHomePage extends StatefulWidget {
  @override
  _HistoryHomePageState createState() => _HistoryHomePageState();
}

class _HistoryHomePageState extends State<HistoryHomePage> {
  final HistoryHomeBloc bloc = HistoryHomeBloc();

  @override
  void initState() {
    bloc.add(GetDataHistoryHomeEvent(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lịch sử'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<HistoryHomeBloc, HistoryHomeState>(
          cubit: bloc,
          builder: (BuildContext context, HistoryHomeState state) {
            if (state is SuccessGetDataHistoryHomeState) {
              return _body(context, state);
            } else if (state is FailGetDataHistoryHomeState) {
              return Container(
                child: Text(state.error),
              );
            } else
              return Container();
          },
          buildWhen: (HistoryHomeState prev, HistoryHomeState current) {
            if (current is TokenExpiredHomeState) {
              _showAlert(context);
              return false;
            } else
              return true;
          },
        ));
  }

  Widget _body(BuildContext context, SuccessGetDataHistoryHomeState state) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Column(
        children: <Widget>[
          if (state.listTicket.isNotEmpty)
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (BuildContext context, int index) {
                    final Ticket ticket = state.listTicket[index];
                    return _historyItem(ticket);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                        height: AVSize.getSize(context, 8),
                      ),
                  itemCount: state.listTicket.length),
            )
          else
            Container(),
          if (state.page == -1)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: HaLanColor.primaryColor,
                valueColor: AlwaysStoppedAnimation<Color>(HaLanColor.white),
              )),
            ),
        ],
      ),
    );
  }

  Widget _historyItem(Ticket ticket) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.historyTicketDetailPage,
            arguments: <String, dynamic>{
              Constant.tickets: ticket.ticketCode
            });
      },
      child: Container(
        padding: EdgeInsets.only(
          left: AVSize.getSize(context, 16),
          top: AVSize.getSize(context, 8),
          bottom: AVSize.getSize(context, 8),
          right: AVSize.getSize(context, 0),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: HaLanColor.white),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  convertTime('HH:mm', ticket.getInTimePlan, true),
                  style: textTheme.subtitle1.copyWith(
                      fontSize: AVSize.getFontSize(context, 24),
                      fontWeight: FontWeight.w500,
                      color: HaLanColor.black),
                ),
                Container(
                  width: AVSize.getSize(context, 8),
                ),
                Image.asset('assets/bus_icon.png'),
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AVSize.getSize(context, 15),
                      vertical: AVSize.getSize(context, 2)),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(4), right: Radius.zero),
                      color: setColorByTicketStatus(ticket)),
                  child: Text(
                    setTitleByTicketStatus(ticket),
                    style: textTheme.bodyText2.copyWith(
                        fontSize: AVSize.getFontSize(context, 12),
                        fontWeight: FontWeight.w600,
                        color: HaLanColor.white),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  convertTime('dd/MM/yyyy', ticket.getInTimePlan, true),
                  style: textTheme.bodyText2.copyWith(
                      fontSize: AVSize.getFontSize(context, 12), height: 5 / 3),
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  ticket.ticketId,
                  style: textTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: AVSize.getFontSize(context, 12),
                      height: 5 / 4,
                      color: HaLanColor.black),
                ),
                Container(
                  width: AVSize.getSize(context, 16),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: AVSize.getSize(context, 150),
                  child: Text(
                    '${ticket.pointUp.name} - ${ticket.pointDown.name}',
                    style: textTheme.bodyText2.copyWith(
                        fontSize: AVSize.getFontSize(context, 12),
                        height: 5 / 3),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  currencyFormat(ticket.agencyPrice.toInt(), 'Đ'),
                  style: textTheme.subtitle1.copyWith(
                      fontSize: AVSize.getFontSize(context, 18),
                      height: 11 / 9,
                      color: HaLanColor.black,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  width: AVSize.getSize(context, 16),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.pixels >
          notification.metrics.maxScrollExtent * 0.9) {
        bloc.add(LoadMoreHistoryHomeEvent());
      }
    }
    return false;
  }

  void _showAlert(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) => AVAlertDialogWidget(
              context: context,
              bottomWidget: Row(
                children: <Widget>[
                  Expanded(
                    child: AVButton(
                      color: HaLanColor.primaryColor,
                      height: AVSize.getSize(context, 40),
                      title: 'Đăng nhập',
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.homeSignInPage);
                      },
                    ),
                  ),
                ],
              ),
              title: 'Hết hạn đăng nhập',
              content: 'Mã đăng nhập đã hết hạn, vui lòng đăng nhập lại',
            ));
  }
}
