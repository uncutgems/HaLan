import 'package:avwidget/av_alert_dialog_widget.dart';
import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/avwidget.dart';
import 'package:avwidget/cus_text_form_field_widget.dart';
import 'package:avwidget/popup_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/size.dart';
import 'package:halan/page/log_in/home_signin_bloc.dart';

class HomeSignInPage extends StatefulWidget {
  @override
  _HomeSignInPageState createState() => _HomeSignInPageState();
}

class _HomeSignInPageState extends State<HomeSignInPage> {
  TextEditingController phoneNumber = TextEditingController();
  FocusNode phoneNumberFocus = FocusNode();
  GlobalKey<FormState> myKey = GlobalKey<FormState>();
  HomeSignInBloc homeSignInBloc = HomeSignInBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    phoneNumber.clear();
    phoneNumberFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeSignInBloc, HomeSignInState>(
      cubit: homeSignInBloc,
      builder: (BuildContext context, HomeSignInState state) {
        if (state is HomeSignInInitial) {
          return logInScreen(context);
        } else {
          return Container();
        }
      },
      buildWhen: (HomeSignInState previous, HomeSignInState current) {
        if (current is FailHomeSignInState) {
          _catchError(context, current.errorMessage);
          return false;
        } else if (current is MoveToNextPageHomeSignInState) {
          Navigator.pop(context);
          Navigator.pushNamed(context, RoutesName.homeOtpPage,
              arguments: <String, dynamic>{
                Constant.phoneNumber: current.phoneNumber,
              });
          return false;
        } else if (current is LoadingHomeSignInState) {
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return const AVLoadingWidget();
              });
          return false;
        }

        return true;
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
          child: Form(
            key: myKey,
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
                CustomerTextFormFieldWidget(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Bạn chưa nhập số điện thoại';
                    }
                    return null;
                  },
                  isPrice: false,
                  hintText: 'Số điện thoại',
                  keyboardType: TextInputType.number,
                  textEditingController: phoneNumber,
                  focusNode: phoneNumberFocus,
                ),
                Container(
                  height: AppSize.getHeight(context, 8),
                ),
                AVButton(
                  width: AppSize.getWidth(context, 343),
                  title: 'Đăng nhập',
                  color: AVColor.orange100,
                  onPressed: () {
                    if (myKey.currentState.validate()) {
                      homeSignInBloc.add(ClickLogInButtonHomeSignInEvent(
                          phoneNumber.text.trim()));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _catchError(BuildContext context, String error) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AVAlertDialogWidget(
            title: 'Lỗi đăng nhập',
            context: context,
            content: 'Không thể đăng nhập vì $error',
            bottomWidget: Center(
              child: AVButton(
                color: HaLanColor.primaryColor,
                title: 'Thử lại?',
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(RoutesName.homeSignInPage));
                },
              ),
            ),
          );
        });
  }
}
