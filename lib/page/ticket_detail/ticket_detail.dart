import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/av_radio_widget.dart';
import 'package:avwidget/avwidget.dart';
import 'package:avwidget/testing_tff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/size.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/ticket_detail/ticket_detail_bloc.dart';

class TicketDetailPage extends StatefulWidget {
  const TicketDetailPage(
      {Key key, @required this.trip, @required this.listSeat})
      : super(key: key);

  final Trip trip;
  final List<Seat> listSeat;

  @override
  _TicketDetailPageState createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  TicketDetailBloc ticketDetailBloc = TicketDetailBloc();
  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  TextEditingController customerNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  FocusNode customerNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode passportFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    customerNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    noteController.dispose();
    ticketDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketDetailBloc, TicketDetailState>(
      cubit: ticketDetailBloc,
//          buildWhen: (HomeState prev, HomeState state) {
//            if (state is LoadingHomeState) {
//              showDialog<dynamic>(
//                  context: context,
//                  builder: (BuildContext context) {
//                    return const AVLoadingWidget();
//                  });
//              return false;
//            } else if (state is DismissLoadingHomeState) {
//              Navigator.pop(context);
//            }
//            return true;
//          },
      builder: (BuildContext context, TicketDetailState state) {
        if (state is TicketDetailInitial) {
          return mainScreen(context, false, false);
        } else if (state is ChangeCheckBoxStatusTicketDetailState) {
          return mainScreen(context, state.firstBoxState, state.secondBoxState);
        }

        return Container();
      },
    );
  }

  Widget mainScreen(BuildContext context, bool box1, bool box2) {
    final TextStyle textStyle = Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(fontWeight: FontWeight.w500)
        .copyWith(fontSize: AppSize.getFontSize(context, 14));
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Form(
        key: myKey,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AVColor.gray100),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            title: Text('Thông tin liên hệ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: AVColor.gray100)
                    .copyWith(fontSize: AppSize.getFontSize(context, 18))
                    .copyWith(fontWeight: FontWeight.w600)),
            centerTitle: true,
            backgroundColor: AVColor.halanBackground,
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: AppSize.getWidth(context, 16),
              right: AppSize.getWidth(context, 16),
            ),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  height: AppSize.getWidth(context, 16),
                ),
                HalanTextFormField(
                  isRequired: true,
                  title: 'Tên khách hàng',
                  titleStyle: textStyle,
                  textEditingController: customerNameController,
                  keyboardType: TextInputType.text,
                  focusNode: customerNameFocusNode,
                  validator: (String value) {
                    if (value == null) {
                      return 'Vui lòng điền tên khách hàng';
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(emailFocusNode);
                  },
                ),
                Container(
                  height: AppSize.getWidth(context, 16),
                ),
                HalanTextFormField(
                  title: 'Số điện thoại',
                  titleStyle: textStyle,
                  isRequired: true,
                  focusNode: phoneNumberFocusNode,
                  textEditingController: phoneNumberController,
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    if (value == null) {
                      return 'Vui lòng điền số điện thoại';
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(passportFocusNode);
                  },
                ),
                Container(
                  height: AppSize.getWidth(context, 16),
                ),
                HalanTextFormField(
                  focusNode: emailFocusNode,
                  title: 'Email',
                  titleStyle: textStyle,
                  textEditingController: emailController,
                  keyboardType: TextInputType.text,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(phoneNumberFocusNode);
                  },
                ),
                Container(
                  height: AppSize.getWidth(context, 16),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Ghi chú',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontWeight: FontWeight.w500)
                          .copyWith(fontSize: AppSize.getFontSize(context, 14)),
                    ),
                  ],
                ),
                Container(
                  height: AppSize.getWidth(context, 8),
                ),
                HalanTextFormField(
                  focusNode: passportFocusNode,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  textEditingController: noteController,
                  keyboardType: TextInputType.text,
                ),
                Container(
                  height: AppSize.getWidth(context, 19),
                ),
                Text(
                  'Hình thức đưa đón',
                  style: textStyle,
                ),
                Container(
                  height: AppSize.getWidth(context, 8),
                ),
                option(context, () {}, textStyle),
                Container(
                  height: AppSize.getWidth(context, 16),
                ),
                option(context, () {}, textStyle),
                Container(
                  height: AppSize.getWidth(context, 19),
                ),
                Row(
                  children: <Widget>[
                    AVRadio<bool>(
                      groupValue: box2,
                      value: true,
                      onTap: () {
                        ticketDetailBloc
                            .add(TickBoxesTicketDetailEvent(box1, !box2));
                      },
                    ),
                    Text(
                      'Tôi đồng ý với',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: AppSize.getFontSize(context, 14))
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      ' điều khoản của Văn Minh',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: AppSize.getFontSize(context, 14))
                          .copyWith(fontWeight: FontWeight.w500)
                          .copyWith(color: HaLanColor.blue),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(AppSize.getWidth(context, 16)),
            child: AVButton(
              title: 'Tiếp tục',
              height: AppSize.getWidth(context, 48),
              width: AppSize.getWidth(context, 343),
              onPressed: () {
                if (myKey.currentState.validate()) {
                  print('vào đây');
//                  final Ticket ticket = Ticket(
//                    createdDate: int.parse(convertTime('ddMMyyy', DateTime.now().millisecondsSinceEpoch, true)),
//                    fullName: customerNameController.text,
//                    phoneNumber: phoneNumberController.text,
//                    ticketStatus: TicketStatus.booked,
//                    getInTimePlan: widget.trip.startTime,
//                    getOffTimePlan: widget.trip.startTime + widget.trip.runTime,
//                    pointUp: widget.trip.pointUp,
//                    pointDown: widget.trip.pointDown,
//                    listSeatId: <String>[]
//
//
//                  );
                  Navigator.pushNamed(
                      context, RoutesName.historyTicketDetailPage,
                      arguments: <String, dynamic>{
                        Constant.ticketCode: '201020-900790'
                      });
                }
              },
              color: HaLanColor.primaryColor,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}

Widget option(BuildContext context, VoidCallback onTap, TextStyle textStyle) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppSize.getWidth(context, 16),
          vertical: AppSize.getWidth(context, 9)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Đón tại bến',
            style: textStyle,
          ),
          const Icon(Icons.expand_more),
        ],
      ),
      height: AppSize.getWidth(context, 40),
      decoration: BoxDecoration(
        color: HaLanColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
