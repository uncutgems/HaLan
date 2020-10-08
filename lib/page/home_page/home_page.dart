import 'package:avwidget/avwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halan/base/size.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return homeScreen(context);
  }

  Widget homeScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: AVColor.halanBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/myicon.svg',
            height: AppSize.getWidth(context, 16),
            width: AppSize.getWidth(context, 16),
          ),
          onPressed: () {},
        ),
        elevation: 0,
        backgroundColor: AVColor.halanBackground,
        title: Text(
          'Xe khách Hà Lan',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: AVColor.gray100)
              .copyWith(fontSize: AppSize.getFontSize(context, 18))
              .copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions:<Widget> [
          Stack(
            children: <Widget>[
              IconButton(icon: null, onPressed: null),
            ],
          ),
        ],
      ),
    );
  }
}
