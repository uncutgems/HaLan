import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/avwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/size.dart';

class HomeOtpPage extends StatefulWidget {
  @override
  _HomeOtpPageState createState() => _HomeOtpPageState();
}

class _HomeOtpPageState extends State<HomeOtpPage> {
  final RoundedRectangleBorder listTileBorder = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return logInScreen(context);
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
                  customTextFormField(),
                  Container(
                    width: AppSize.getWidth(context, 8),
                  ),
                  Container(
                    color: HaLanColor.white,
                    height: AppSize.getWidth(context, 60),
                    width: AppSize.getWidth(context, 45),
                  ),
                  Container(
                    width: AppSize.getWidth(context, 8),
                  ),
                  Container(
                    color: HaLanColor.white,
                    height: AppSize.getWidth(context, 60),
                    width: AppSize.getWidth(context, 45),
                  ),
                  Container(
                    width: AppSize.getWidth(context, 8),
                  ),
                  Container(
                    color: HaLanColor.white,
                    height: AppSize.getWidth(context, 60),
                    width: AppSize.getWidth(context, 45),
                  ),
                  Container(
                    width: AppSize.getWidth(context, 8),
                  ),
                  Container(
                    color: HaLanColor.white,
                    height: AppSize.getWidth(context, 60),
                    width: AppSize.getWidth(context, 45),
                  ),
                  Container(
                    width: AppSize.getWidth(context, 8),
                  ),
                  Container(
                    color: HaLanColor.white,
                    height: AppSize.getWidth(context, 60),
                    width: AppSize.getWidth(context, 45),
                  ),
                ],
              ),
              Container(
                height: AppSize.getHeight(context, 16),
              ),
              AVButton(
                width: AppSize.getWidth(context, 343),
                title: 'Đăng nhập',
                color: AVColor.orange100,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextFormField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: HaLanColor.white,
      ),
      height: AppSize.getWidth(context, 60),
      width: AppSize.getWidth(context, 45),
      child: Center(
        child: TextFormField(
          textAlign: TextAlign.center,
          cursorColor: HaLanColor.white,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(1),
          ],
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
