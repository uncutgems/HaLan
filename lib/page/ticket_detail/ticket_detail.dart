import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/av_radio_widget.dart';
import 'package:avwidget/avwidget.dart';
import 'package:avwidget/testing_tff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/size.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/ticket_detail/ticket_detail_bloc.dart';
import 'package:halan/widget/transhipment_selection.dart';

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
  TicketDetailBloc bloc = TicketDetailBloc();
  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  TextEditingController customerNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  FocusNode customerNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode passportFocusNode = FocusNode();
  String pickUp = 'Đón tại bến';
  String dropOff = 'Trả tại bến';
  Point transshipmentUp;
  Point transshipmentDown;
  bool check = false;

  @override
  void initState() {
    if(widget.trip!=null){
      if(widget.trip.pointUp.listTransshipmentPoint.isNotEmpty){
        transshipmentUp= widget.trip.pointUp.listTransshipmentPoint.first;
      }
      if(widget.trip.pointDown.listTransshipmentPoint.isNotEmpty){
        transshipmentDown= widget.trip.pointDown.listTransshipmentPoint.first;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    customerNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    noteController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketDetailBloc, TicketDetailState>(
      cubit: bloc,
      builder: (BuildContext context, TicketDetailState state) {

        if (state is TicketDetailInitial) {
          return mainScreen(context, false, widget.trip.pointUp,
              widget.trip.pointDown);
        } else if (state is TicketDetailChangeCheckBoxState) {
          pickUp= state.pickUp;
          dropOff=state.dropDown;
          check=state.firstBoxState;
          transshipmentUp=state.pointUp;
          transshipmentDown=state.pointDown;
          return mainScreen(context, state.firstBoxState,
              widget.trip.pointUp, widget.trip.pointDown);
        }

        return Container();
      },
    );
  }

  Widget mainScreen(BuildContext context, bool box1, Point pointUp,
      Point pointDown) {
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
                option(context, () {
                  pickAndDropOptions(context, 'Đón', pointUp);
                }, textStyle,
                    optionText: pickUp,
                    point: pointUp,
                    transhipmentName: pointUp.listTransshipmentPoint.isNotEmpty
                        ? transshipmentUp.name
                        : null),
                Container(
                  height: AppSize.getWidth(context, 16),
                ),
                option(context, () {
                  pickAndDropOptions(context, 'Trả', pointDown);
                }, textStyle,
                    optionText: dropOff,
                    point: pointDown,
                    transhipmentName:
                        pointDown.listTransshipmentPoint.isNotEmpty
                            ? transshipmentDown.name
                            : null),
                Container(
                  height: AppSize.getWidth(context, 19),
                ),
                Row(
                  children: <Widget>[
                    AVRadio<bool>(
                      groupValue: box1,
                      value: true,
                      onTap: () {
                        bloc.add(TickBoxesTicketDetailEvent(!box1,pickUp,dropOff,transshipmentUp,transshipmentDown));
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
                Container(height: AppSize.getWidth(context, 16),),
                Row(
                  children: <Widget>[
                    Text('Tổng tiền',),
                    if (widget.trip!=null && widget.listSeat!=null)
                      Text('${calculatorPrice(widget.trip, widget.listSeat, pointUp, pointDown)}',)
                  ],
                )
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(AppSize.getWidth(context, 16)),
            child: AVButton(
              title: 'Tiếp tục',
              height: AppSize.getWidth(context, 48),
              width: AppSize.getWidth(context, 343),
              onPressed: check==false?null:() {
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
//                  );
                  Navigator.pushNamed(
                      context, RoutesName.historyTicketDetailPage,
                      arguments: <String, dynamic>{
                        Constant.ticketCode: '201021-359735'
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

  Widget option(BuildContext context, VoidCallback onTap, TextStyle textStyle,
      {String optionText, Point point, String transhipmentName}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.getWidth(context, 16),
                vertical: AppSize.getWidth(context, 9)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  optionText,
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
        ),
        if (optionText.contains('trung chuyển'))
          Padding(
            padding: EdgeInsets.only(top: AppSize.getWidth(context, 8)),
            child: AVButton(
              radius: 4,
              width: MediaQuery.of(context).size.width,
              title: optionText.toLowerCase().trim().contains('đón')
                  ? transshipmentUp.name
                  : transshipmentDown.name,
              onPressed: () {

                showModalBottomSheet<dynamic>(
                    context: context,
                    builder: (BuildContext context) {
                      return TransshipmentSelections(
                        point: point,
                        transshipmentPoint: (Point transshipmentPoint) {
                          print(transshipmentPoint.name);
                          if (optionText.toLowerCase().trim().contains('đón')) {
                            transshipmentUp = transshipmentPoint;
                            print(transshipmentUp);
                          } else {
                            transshipmentDown = transshipmentPoint;
                          }
                          bloc.add(TickBoxesTicketDetailEvent(check,pickUp,dropOff,transshipmentUp,transshipmentDown));
//                          print(transhipmentName);
                          Navigator.pop(context);
                        },
                      );
                    });
              },
            ),
          ),
      ],
    );
  }

  void pickAndDropOptions(BuildContext context, String option, Point point) {
    showModalBottomSheet<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.getWidth(context, 8),
                vertical: AppSize.getWidth(context, 8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Chọn hình thức ${option.toLowerCase()}',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.getFontSize(context, 18)),
                ),
                Padding(
                  padding: EdgeInsets.all(AppSize.getWidth(context, 16)),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listOfOption(context, option, point)),
                ),
              ],
            ),
          );
        });
  }

  List<Widget> listOfOption(BuildContext context, String type, Point point) {
    final List<Widget> result = <Widget>[];
    result.add(GestureDetector(
      onTap: () {
        if (type.trim() == 'Đón') {
          pickUp = '$type tại bến';
        } else {
          dropOff = '$type tại bến';
        }
        bloc.add(TickBoxesTicketDetailEvent(check,pickUp,dropOff,transshipmentUp,transshipmentDown));
        Navigator.pop(context);
      },
      child: Text(
        '$type tại bến',
        style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontSize: AppSize.getFontSize(context, 16),
            ),
      ),
    ));
    if (point.listTransshipmentPoint.isNotEmpty) {
      result.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppSize.getWidth(context, 8)),
          child: GestureDetector(
            onTap: () {
              if (type.trim() == 'Đón') {
                pickUp = '$type tại trung chuyển';
              } else {
                dropOff = '$type tại trung chuyển';
              }
              bloc.add(TickBoxesTicketDetailEvent(check,pickUp,dropOff,transshipmentUp,transshipmentDown));
              Navigator.pop(context);
            },
            child: Text(
              '$type tại trung chuyển',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: AppSize.getFontSize(context, 16)),
            ),
          ),
        ),
      );
    }
    return result;
  }
}
