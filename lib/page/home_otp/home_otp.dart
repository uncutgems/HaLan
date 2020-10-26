import 'package:avwidget/av_alert_dialog_widget.dart';
import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/avwidget.dart';
import 'package:avwidget/popup_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/main.dart';
import 'package:halan/base/size.dart';
import 'package:halan/page/home_otp/home_otp_bloc.dart';
import 'package:halan/widget/count_down_widget/count_down.dart';

class HomeOtpPage extends StatefulWidget {
  const HomeOtpPage({Key key, this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  _HomeOtpPageState createState() => _HomeOtpPageState();
}

class _HomeOtpPageState extends State<HomeOtpPage>
    with SingleTickerProviderStateMixin {
  HomeOtpBloc homeOtpBloc = HomeOtpBloc();

  TextEditingController firstPinController = TextEditingController();
  TextEditingController secondPinController = TextEditingController();
  TextEditingController thirdPinController = TextEditingController();
  TextEditingController forthPinController = TextEditingController();
  TextEditingController fifthPinController = TextEditingController();
  TextEditingController sixthPinController = TextEditingController();

  FocusNode firstFocusNode = FocusNode();
  FocusNode secondFocusNode = FocusNode();
  FocusNode thirdFocusNode = FocusNode();
  FocusNode forthFocusNode = FocusNode();
  FocusNode fifthFocusNode = FocusNode();
  FocusNode sixthFocusNode = FocusNode();
  String phoneNumber;

  AnimationController _controller;

  String pin_1;
  String pin_2;
  String pin_3;
  String pin_4;
  String pin_5;
  String pin_6;

  final RoundedRectangleBorder listTileBorder = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
  );

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    homeOtpBloc.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeOtpBloc, HomeOtpState>(
      cubit: homeOtpBloc,
      buildWhen: (HomeOtpState prev, HomeOtpState state) {
        if (state is LoadingHomeOtpState) {
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return const AVLoadingWidget();
              });
          return false;
        } else if (state is DismissLoadingHomeOtpState) {
          Navigator.pop(context);
          return false;
        } else if (state is LogInSuccessfullyHomeOtpState) {
          if (prefs.getBool(Constant.haveChoseSeat) == true ) {
            Navigator.popUntil(
                context, ModalRoute.withName(RoutesName.ticketConfirmPage));
            return false;
          } else {
            Navigator.popUntil(
                context, ModalRoute.withName(RoutesName.busBookingPage));
            return false;
          }
        } else if (state is FailToLoginHomeOtpState) {
          _showAlert(
              context, 'Chú ý!', 'Mã OTP không chính xác hoặc hết thời hạn');
          return false;
        }
        return true;
      },
      builder: (BuildContext context, HomeOtpState state) {
        if (state is HomeOtpInitial) {
          return logInScreen(context);
        } else if (state is ReloadPageHomeOtpState) {
          _controller.reset();
          _controller.forward();

          return logInScreen(context);
        }
        return Container();
      },
    );
  }

  Widget logInScreen(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: AVColor.halanBackground,
          title: Text(
            'Đăng nhập',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: AVColor.gray100)
                .copyWith(fontSize: AppSize.getFontSize(context, 18))
                .copyWith(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: AppSize.getWidth(context, 16),
            right: AppSize.getWidth(context, 16),
          ),
          child: ListView(
            children: <Widget>[
              Container(
                height: AppSize.getHeight(context, 52),
              ),
              SvgPicture.asset(
                'assets/halan_logo.svg',
                height: AppSize.getWidth(context, 80),
                width: AppSize.getWidth(context, 173),
              ),
              Container(
                height: AppSize.getHeight(context, 40),
              ),
              Text(
                'Vui lòng nhập mã OTP được gửi đến số điện thoại của bạn',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: AVColor.gray100)
                    .copyWith(fontSize: AppSize.getFontSize(context, 14))
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              Container(
                height: AppSize.getHeight(context, 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  customTextFormField(
                    firstPinController,
                    firstFocusNode,
                    () {
                      FocusScope.of(context).requestFocus(secondFocusNode);
                    },
                    (String pin) {
                      if (pin.length == 1) {
                        FocusScope.of(context).requestFocus(secondFocusNode);
                        pin_1 = pin;
                      } else if (pin.isEmpty) {
                        FocusScope.of(context).requestFocus(firstFocusNode);
                      }
                    },
                  ),
                  Container(
                    width: AppSize.getWidth(context, 8),
                  ),
                  customTextFormField(secondPinController, secondFocusNode, () {
                    FocusScope.of(context).requestFocus(thirdFocusNode);
                  }, (String pin) {
                    if (pin.length == 1) {
                      FocusScope.of(context).requestFocus(thirdFocusNode);
                      pin_2 = pin;
                    } else if (pin.isEmpty) {
                      FocusScope.of(context).requestFocus(firstFocusNode);
                    }
                  }),
                  Container(
                    width: AppSize.getWidth(context, 8),
                  ),
                  customTextFormField(thirdPinController, thirdFocusNode, () {
                    FocusScope.of(context).requestFocus(forthFocusNode);
                  }, (String pin) {
                    if (pin.length == 1) {
                      FocusScope.of(context).requestFocus(forthFocusNode);
                      pin_3 = pin;
                    } else if (pin.isEmpty) {
                      FocusScope.of(context).requestFocus(secondFocusNode);
                    }
                  }),
                  Container(
                    width: AppSize.getWidth(context, 8),
                  ),
                  customTextFormField(forthPinController, forthFocusNode, () {
                    FocusScope.of(context).requestFocus(fifthFocusNode);
                  }, (String pin) {
                    if (pin.length == 1) {
                      FocusScope.of(context).requestFocus(fifthFocusNode);
                      pin_4 = pin;
                    } else if (pin.isEmpty) {
                      FocusScope.of(context).requestFocus(thirdFocusNode);
                    }
                  }),
                  Container(
                    width: AppSize.getWidth(context, 8),
                  ),
                  customTextFormField(fifthPinController, fifthFocusNode, () {
                    FocusScope.of(context).requestFocus(sixthFocusNode);
                  }, (String pin) {
                    if (pin.length == 1) {
                      FocusScope.of(context).requestFocus(sixthFocusNode);
                      pin_5 = pin;
                    } else if (pin.isEmpty) {
                      FocusScope.of(context).requestFocus(forthFocusNode);
                    }
                  }),
                  Container(
                    width: AppSize.getWidth(context, 8),
                  ),
                  customTextFormField(sixthPinController, sixthFocusNode,
                      () => FocusScope.of(context).requestFocus(FocusNode()),
                      (String pin) {
                    if (pin.length == 1) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      pin_6 = pin;
                    } else if (pin.isEmpty) {
                      FocusScope.of(context).requestFocus(fifthFocusNode);
                    }
                  }),
                ],
              ),
              Container(
                height: AppSize.getHeight(context, 16),
              ),
              AVButton(
                width: AppSize.getWidth(context, 343),
                title: 'Đăng nhập',
                color: AVColor.orange100,
                onPressed: checkPinCode(
                        fifthPinController.text,
                        secondPinController.text,
                        thirdPinController.text,
                        forthPinController.text,
                        fifthPinController.text,
                        sixthPinController.text)
                    ? () {
                        phoneNumber = widget.phoneNumber;

                        print(firstPinController.text +
                            secondPinController.text +
                            thirdPinController.text +
                            forthPinController.text +
                            fifthPinController.text +
                            sixthPinController.text);
                        homeOtpBloc.add(ClickLogInButtonHomeOtpEvent(
                            phoneNumber,
                            firstPinController.text +
                                secondPinController.text +
                                thirdPinController.text +
                                forthPinController.text +
                                fifthPinController.text +
                                sixthPinController.text));
                      }
                    : null,
              ),
              Container(
                height: AppSize.getWidth(context, 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Countdown(
                    animation: StepTween(
                      begin: 1 * 60,
                      end: 0,
                    ).animate(_controller),
                    controller: _controller,
                    onPressed: () {
                      phoneNumber = widget.phoneNumber;
                      print('Fuck $phoneNumber');
                      homeOtpBloc.add(ClickSendAgainHomeOtpEvent(phoneNumber));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkPinCode(String pin1, String pin2, String pin3, String pin4,
      String pin5, String pin6) {
    if (pin1.isEmpty ||
        pin1 == null ||
        pin2.isEmpty ||
        pin2 == null ||
        pin3.isEmpty ||
        pin3 == null ||
        pin4.isEmpty ||
        pin4 == null ||
        pin5.isEmpty ||
        pin5 == null ||
        pin6.isEmpty ||
        pin6 == null) {
      return false;
    } else {
      return true;
    }
  }

  Widget customTextFormField(
    TextEditingController textEditingController,
    FocusNode focusNode,
    VoidCallback onEditingComplete,
    ValueChanged<String> onChanged,
  ) {
    final OutlineInputBorder myBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: HaLanColor.red100, width: 1),
    );
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: HaLanColor.borderColor),
        borderRadius: BorderRadius.circular(4),
        color: HaLanColor.white,
      ),
      height: AppSize.getWidth(context, 60),
      width: AppSize.getWidth(context, 45),
      child: Center(
        child: TextFormField(
          onChanged: onChanged,
          keyboardType: TextInputType.number,
          style: TextStyle(
              color: HaLanColor.black,
              fontSize: AppSize.getFontSize(context, 30)),
          onEditingComplete: onEditingComplete,
          focusNode: focusNode,
          controller: textEditingController,
          textAlign: TextAlign.center,
          cursorColor: HaLanColor.white,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(1),
          ],
          decoration: InputDecoration(
            border: myBorder,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  void _showAlert(BuildContext context, String title, String content) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => AVAlertDialogWidget(
        context: context,
        title: title, //'Vui lòng chọn khoản mục!',
        content: content, //'Bạn chưa chọn khoản mục nào',
        bottomWidget: ButtonBar(
          children: <Widget>[
            AVButton(
              height: AppSize.getHeight(context, 28),
              title: 'Đóng',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
