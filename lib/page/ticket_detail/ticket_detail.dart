import 'package:avwidget/av_alert_dialog_widget.dart';
import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/av_radio_widget.dart';
import 'package:avwidget/av_text_form_field_widget.dart';
import 'package:avwidget/avwidget.dart';
import 'package:avwidget/popup_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/size.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/main.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/model/enum.dart';
import 'package:halan/page/ticket_detail/ticket_detail_bloc.dart';
import 'package:halan/widget/promotion/promotion_view.dart';
import 'package:halan/widget/transhipment_selection.dart';

class TicketDetailPage extends StatefulWidget {
  const TicketDetailPage(
      {Key key, @required this.trip, @required this.listSeat, this.totalMoney})
      : super(key: key);

  final Trip trip;
  final List<Seat> listSeat;
  final int totalMoney;

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
  TextEditingController homePickUpController = TextEditingController();
  TextEditingController homeDropOffController = TextEditingController();
  FocusNode customerNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode noteFocusNode = FocusNode();
  String pickUp = '????n t???i b???n';
  String dropOff = 'Tr??? t???i b???n';
  Point transshipmentUp;
  Point transshipmentDown;
  bool check = false;
  int totalMoney = 0;

  int transshipmentUpPrice = 0;
  int transshipmentDownPrice = 0;

  @override
  void initState() {
    if(prefs!=null){
      if(prefs.containsKey(Constant.fullName)){
        customerNameController.text = prefs.getString(Constant.fullName);
      }
      if(prefs.containsKey(Constant.phoneNumber)){
        phoneNumberController.text = prefs.getString(Constant.phoneNumber);
      }
    }
    if (widget.trip != null) {
      print(
          'sssssssssssssssss ${widget.trip.pointDown.allowPickingAnddropingAtHomeByPlatform.contains(prefs.getInt(Constant.platform))}');
      if (widget.trip.pointUp.listTransshipmentPoint.isNotEmpty) {
        transshipmentUp = widget.trip.pointUp.listTransshipmentPoint.first;
        transshipmentUpPrice = transshipmentUp.transshipmentPrice.toInt();
      }
      if (widget.trip.pointDown.listTransshipmentPoint.isNotEmpty) {
        transshipmentDown = widget.trip.pointDown.listTransshipmentPoint.first;
        transshipmentDownPrice = transshipmentDown.transshipmentPrice.toInt();
      }

      totalMoney = calculatePrice(widget.trip, widget.listSeat,
              widget.trip.pointUp, widget.trip.pointDown)
          .toInt();
    }
    super.initState();
  }

  @override
  void dispose() {
    customerNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    noteController.dispose();
    customerNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    noteFocusNode.dispose();
    homeDropOffController.dispose();
    homePickUpController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketDetailBloc, TicketDetailState>(
      cubit: bloc,
      buildWhen: (TicketDetailState prev, TicketDetailState state) {
        if (state is TicketDetailLoadingState) {
          showPopupLoading(context);
          return false;
        } else if (state is TicketDetailDismissLoadingState) {
          Navigator.pop(context);
          return false;
        } else if (state is TicketDetailNextPageState) {
          Navigator.pushNamed(context, RoutesName.historyTicketDetailPage,
              arguments: <String, dynamic>{
                Constant.ticketCode: state.ticketCode
              });
          return false;
        } else if (state is TicketDetailFailState) {
          fail(context, state.error);
          return false;
        }
        return true;
      },
      builder: (BuildContext context, TicketDetailState state) {
        if (state is TicketDetailInitial) {
          return mainScreen(
              context, false, widget.trip.pointUp, widget.trip.pointDown);
        } else if (state is TicketDetailChangeCheckBoxState) {
          totalMoney = state.totalMoney;
          pickUp = state.pickUp;
          dropOff = state.dropDown;
          check = state.firstBoxState;
          transshipmentUp = state.pointUp;
          transshipmentDown = state.pointDown;
          print('kkkkkkkkkkkkkkkkkkk ${transshipmentUp.id}');
          return mainScreen(context, state.firstBoxState, widget.trip.pointUp,
              widget.trip.pointDown);
        }

        return Container();
      },
    );
  }

  Widget mainScreen(
      BuildContext context, bool box1, Point pointUp, Point pointDown) {
    if (pickUp.contains('trung chuy???n')) {
      pointUp = pointUp.copyWith(
        pointType: TransportType.transshipment,
        transshipmentId: transshipmentUp.id,
        name: transshipmentUp.name,
        address: transshipmentUp.address,
        transshipmentPrice: transshipmentUpPrice.toDouble(),
      );
    } else if (!pickUp.contains('trung chuy???n')) {
      pointUp = setUpPointType(pickUp, pointUp,
          homeAddress: homePickUpController.text);
      print(pointUp.listPrice);
      print(widget.trip.pointUp.listPrice);
    }
    if (dropOff.contains('trung chuy???n')) {
      pointDown = pointDown.copyWith(
          pointType: TransportType.transshipment,
          transshipmentId: transshipmentDown.id,
          name: transshipmentDown.name,
          address: transshipmentDown.address,
        transshipmentPrice: transshipmentDownPrice.toDouble(),
      );
    } else if (!dropOff.contains('trung chuy???n')) {
      pointDown = setUpPointType(dropOff, pointDown,
          homeAddress: homeDropOffController.text);
    }


    final TextStyle textStyle = Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(fontWeight: FontWeight.w500)
        .copyWith(fontSize: AppSize.getFontSize(context, 14));

    setUpPointType(pickUp, pointUp);
    setUpPointType(dropOff, pointDown);
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
            title: Text('Th??ng tin li??n h???',
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
                AVTextFormFieldBox(
                  isRequired: true,
                  hintText: 'T??n kh??ch h??ng',
                  textEditingController: customerNameController,
                  keyboardType: TextInputType.text,
                  focusNode: customerNameFocusNode,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Vui l??ng ??i???n t??n kh??ch h??ng';
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(phoneNumberFocusNode);
                  },
                ),
                Container(
                  height: AppSize.getWidth(context, 16),
                ),
                AVTextFormFieldBox(
                  hintText: 'S??? ??i???n tho???i',
//                  titleStyle: textStyle,
                  isRequired: true,
                  focusNode: phoneNumberFocusNode,
                  textEditingController: phoneNumberController,
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    print('asssssssssssssssssss $value');
                    if (value.isEmpty) {
                      return 'Vui l??ng ??i???n s??? ??i???n tho???i';
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
                AVTextFormFieldBox(
                  focusNode: emailFocusNode,
                  hintText: 'Email',
                  textEditingController: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(noteFocusNode);
                  },
                ),
                Container(
                  height: AppSize.getWidth(context, 16),
                ),
                AVTextFormFieldBox(
                  hintText: 'Ghi ch??',
                  focusNode: noteFocusNode,
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
                  'H??nh th???c ????a ????n',
                  style: textStyle,
                ),
                Container(
                  height: AppSize.getWidth(context, 8),
                ),
                option(context, () {
                  pickAndDropOptions(context, '????n', pointUp);
                }, textStyle,
                    optionText: pickUp,
                    point: pointUp,
                    transhipmentName: pointUp.listTransshipmentPoint.isNotEmpty
                        ? transshipmentUp.name
                        : null),
                Container(
                  height: AppSize.getWidth(context, 8),
                ),
                if (pickUp.contains('nh??'))
                  AVTextFormFieldBox(
                    hintText: '?????a ch??? nh??',
                    keyboardType: TextInputType.text,
                    textEditingController: homePickUpController,
                  ),
                Container(
                  height: AppSize.getWidth(context, 8),
                ),
                option(context, () {
                  pickAndDropOptions(context, 'Tr???', pointDown);
                }, textStyle,
                    optionText: dropOff,
                    point: pointDown,
                    transhipmentName:
                        pointDown.listTransshipmentPoint.isNotEmpty
                            ? transshipmentDown.name
                            : null),
                Container(
                  height: AppSize.getWidth(context, 8),
                ),
                if (dropOff.contains('nh??'))
                  AVTextFormFieldBox(
                    hintText: '?????a ch??? nh??',
                    keyboardType: TextInputType.text,
                    textEditingController: homeDropOffController,
                  ),
                Container(
                  height: AppSize.getWidth(context, 19),
                ),
                Row(
                  children: <Widget>[
                    AVRadio<bool>(
                      groupValue: box1,
                      value: true,
                      onTap: () {
                        bloc.add(TickBoxesTicketDetailEvent(
                            !box1,
                            pickUp,
                            dropOff,
                            transshipmentUp,
                            transshipmentDown,
                            calculatePrice(widget.trip, widget.listSeat, pointUp, pointDown).toInt()));
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: 'T??i ?????ng ?? v???i',
                            style: textStyle,
                            children: <TextSpan>[
                              TextSpan(
                                text: ' ??i???u kho???n c???a V??n Minh',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        fontSize:
                                            AppSize.getFontSize(context, 14))
                                    .copyWith(fontWeight: FontWeight.w500)
                                    .copyWith(color: HaLanColor.blue),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: AppSize.getWidth(context, 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'T???ng ti???n',
                      style: textStyle,
                    ),
                    if (widget.trip != null && widget.listSeat != null)
                      Text(
                        currencyFormat(totalMoney, '??'),
                        style: textStyle.copyWith(
                            color: HaLanColor.red100,
                            fontWeight: FontWeight.bold),
                      )
                  ],
                ),
                PromotionWidget(
                  routeId: widget.trip != null ? widget.trip.route.id : null,
                  totalMoney: widget.trip != null && widget.listSeat != null
                      ? calculatePrice(
                              widget.trip, widget.listSeat, pointUp, pointDown)
                          .toInt()
                      : null,
                  promotionObject: (PromotionObject promotion) {
                      if (widget.trip != null && widget.listSeat != null) {
                        if(promotion.minPriceApply!=null) {
                          if (promotion.minPriceApply < totalMoney) {
                            if (promotion.percent != -1) {
                              totalMoney =
                                  (totalMoney - totalMoney * promotion.percent)
                                      .toInt();
                            }
                            if (promotion.price != -1) {
                              totalMoney =
                                  (totalMoney - promotion.price).toInt();
                            }
                            bloc.add(TickBoxesTicketDetailEvent(check, pickUp,
                                dropOff, pointUp, pointDown, totalMoney));
                          }
                        }
                      }

                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(AppSize.getWidth(context, 16)),
            child: AVButton(
              title: 'Ti???p t???c',
              height: AppSize.getWidth(context, 48),
              width: AppSize.getWidth(context, 343),
              onPressed: check == false
                  ? null
                  : () {
                      if (myKey.currentState.validate()) {
                        print('v??o ????y');
                        bloc.add(TicketDetailClickButtonEvent(
                          phoneNumber: phoneNumberController.text,
                          fullName: customerNameController.text,
                          note: noteController.text,
                          pointUp: pointUp,
                          pointDown: pointDown,
                          trip: widget.trip,
                          seatSelected: widget.listSeat,
                          totalPrice: totalMoney.toDouble(),
                          email: emailController.text,
                        ));
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
        if (optionText.contains('trung chuy???n'))
          Padding(
            padding: EdgeInsets.only(top: AppSize.getWidth(context, 8)),
            child: AVButton(
              radius: 4,
              width: MediaQuery.of(context).size.width,
              title: optionText.toLowerCase().trim().contains('????n')
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
                          updateMoney(optionText, transshipmentPoint);
                          bloc.add(TickBoxesTicketDetailEvent(
                              check,
                              pickUp,
                              dropOff,
                              transshipmentUp,
                              transshipmentDown,
                              totalMoney));
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

  void updateMoney(String optionText, Point transshipmentPoint) {
    if (optionText.toLowerCase().trim().contains('????n')) {
      transshipmentUp = transshipmentPoint;
//      totalMoney = totalMoney - extraUp;
      transshipmentUpPrice = transshipmentPoint.transshipmentPrice.toInt();
//      totalMoney = totalMoney + extraUp;
      print(transshipmentUp);
    } else {
      transshipmentDown = transshipmentPoint;
//      totalMoney = totalMoney - extraDown;
      transshipmentDownPrice = transshipmentPoint.transshipmentPrice.toInt();
//      totalMoney = totalMoney + extraDown;
    }
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
                  'Ch???n h??nh th???c ${option.toLowerCase()}',
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
        if (type.trim() == '????n') {
          pickUp = '$type t???i b???n';
        } else {
          dropOff = '$type t???i b???n';
        }
        bloc.add(TickBoxesTicketDetailEvent(check, pickUp, dropOff,
            transshipmentUp, transshipmentDown, totalMoney));
        Navigator.pop(context);
      },
      child: Text(
        '$type t???i b???n',
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
              if (type.trim() == '????n') {
                pickUp = '$type t???i trung chuy???n';
              } else {
                dropOff = '$type t???i trung chuy???n';
              }
              bloc.add(TickBoxesTicketDetailEvent(check, pickUp, dropOff,
                  transshipmentUp, transshipmentDown, totalMoney));
              Navigator.pop(context);
            },
            child: Text(
              '$type t???i trung chuy???n',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: AppSize.getFontSize(context, 16)),
            ),
          ),
        ),
      );
    }
    if (point.allowPickingAnddropingAtHomeByPlatform != null) {
      if (point.allowPickingAnddropingAtHomeByPlatform
          .contains(prefs.getInt(Constant.platform))) {
        result.add(
          GestureDetector(
            onTap: () {
              if (type.trim() == '????n') {
                pickUp = '$type t???i nh??';
//                totalMoney = totalMoney - extraUp;
              } else {
                dropOff = '$type t???i nh??';
//                totalMoney = totalMoney - extraDown;
              }
              bloc.add(TickBoxesTicketDetailEvent(check, pickUp, dropOff,
                  transshipmentUp, transshipmentDown, totalMoney));
            },
            child: Text(
              '$type t???i nh??',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: AppSize.getFontSize(context, 16),
                  ),
            ),
          ),
        );
      }
    }
    return result;
  }

  void fail(BuildContext context, String error) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AVAlertDialogWidget(
            title: 'L???i',
            context: context,
            content: error,
            bottomWidget: Center(
              child: AVButton(
                height: AppSize.getWidth(context, 40),
                color: HaLanColor.primaryColor,
                title: 'Th??? l???i',
                onPressed: () {
                  Navigator.pop(context);
                  bloc.add(TicketDetailClickButtonEvent(
                    phoneNumber: phoneNumberController.text,
                    fullName: customerNameController.text,
                    note: noteController.text,
                    pointUp: transshipmentUp,
                    pointDown: transshipmentDown,
                    trip: widget.trip,
                    seatSelected: widget.listSeat,
                    totalPrice: calculatePrice(widget.trip, widget.listSeat,
                        transshipmentUp, transshipmentDown),
                    email: emailController.text,
                  ));
                },
              ),
            ),
          );
        });
  }
}
