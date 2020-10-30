import 'package:avwidget/av_alert_dialog_widget.dart';
import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/avwidget.dart';
import 'package:avwidget/popup_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/config.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/main.dart';
import 'package:halan/base/size.dart';
import 'package:halan/page/home_otp/home_otp_bloc.dart';
import 'package:halan/widget/count_down_widget/count_down.dart';
import 'package:halan/widget/ping_code_text_field.dart';

class HomeOtpPage extends StatefulWidget {
  const HomeOtpPage({Key key, this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  _HomeOtpPageState createState() => _HomeOtpPageState();
}

class _HomeOtpPageState extends State<HomeOtpPage>
    with SingleTickerProviderStateMixin {
  HomeOtpBloc homeOtpBloc = HomeOtpBloc();

  TextEditingController pinController = TextEditingController();

//  TextEditingController firstPinController = TextEditingController();
//  TextEditingController secondPinController = TextEditingController();
//  TextEditingController thirdPinController = TextEditingController();
//  TextEditingController forthPinController = TextEditingController();
//  TextEditingController fifthPinController = TextEditingController();
//  TextEditingController sixthPinController = TextEditingController();

//  FocusNode firstFocusNode = FocusNode();
//  FocusNode secondFocusNode = FocusNode();
//  FocusNode thirdFocusNode = FocusNode();
//  FocusNode forthFocusNode = FocusNode();
//  FocusNode fifthFocusNode = FocusNode();
//  FocusNode sixthFocusNode = FocusNode();
  String phoneNumber;

  AnimationController _controller;

  String pin_1;
  String pin_2;
  String pin_3;
  String pin_4;
  String pin_5;
  String pin_6;

  LoginType loginType = LoginType.call;
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
    pinController.dispose();
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
          if (prefs.getBool(Constant.haveChoseSeat) == true) {
            Navigator.popUntil(
                context, ModalRoute.withName(RoutesName.ticketConfirmPage));
            return false;
          } else {
            Navigator.popUntil(
                context, ModalRoute.withName(RoutesName.busBookingPage));
            Navigator.popAndPushNamed(context, RoutesName.busBookingPage,
                arguments: <String, dynamic>{Constant.refreshPage: true});
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
              if (loginType == LoginType.call) callOTP(context),
              if (loginType == LoginType.sendMessage) messageOTP(context),
              Container(
                height: AppSize.getHeight(context, 16),
              ),
              AVButton(
                width: AppSize.getWidth(context, 343),
                title: 'Đăng nhập',
                color: AVColor.orange100,
                onPressed: checkPinCode()
                    ? () {
                        phoneNumber = widget.phoneNumber;
                        print(pinController.text);
                        homeOtpBloc.add(ClickLogInButtonHomeOtpEvent(
                            phoneNumber,
                           pinController.text));
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

 bool checkPinCode(){
    if(loginType ==LoginType.call){
      if(pinController.text.length==4){
        return true;
      }
      else{
        return false;
      }
    }
    else if(loginType==LoginType.sendMessage){
      if(pinController.text.length==6){
        return true;
      }
      else{
        return false;
      }
    }
    return false;
 }

  Widget messageOTP(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Expanded(
        child: PinCodeTextField(
        height: 100,
        controller: pinController,
        defaultBorderColor: HaLanColor.blue,
        maxLength: 6,
        textColor: HaLanColor.black,
          pinBoxDecoration: (Color color){
            return BoxDecoration(color: HaLanColor.white,
                borderRadius: BorderRadius.circular(AppSize.getWidth(context, 8)),
                border: Border.all(
                  color: HaLanColor.primaryColor,
                  width: 2.0,));
          },
    ),
      ),
    ]);
  }

  Widget callOTP(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      PinCodeTextField(
        height: 100,
        controller: pinController,
        textSize: AppSize.getFontSize(context, 30),
        maxLength: 4,
        textColor: HaLanColor.black,
        pinBoxDecoration: (Color color){
          return BoxDecoration(color: HaLanColor.white,
          borderRadius: BorderRadius.circular(AppSize.getWidth(context, 8)),
          border: Border.all(
            color: HaLanColor.primaryColor,
            width: 2.0,));
        },
      ),
    ]);
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
          cursorColor: HaLanColor.black,
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
