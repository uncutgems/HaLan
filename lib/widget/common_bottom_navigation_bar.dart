import 'package:flutter/material.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/size.dart';

class CommonBottomNavigationBar extends StatefulWidget {
  const CommonBottomNavigationBar({Key key, this.content}) : super(key: key);
  final Widget content;

  @override
  _CommonBottomNavigationBarState createState() =>
      _CommonBottomNavigationBarState();
}

class _CommonBottomNavigationBarState extends State<CommonBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: AppSize.getHeight(context, 80),
          decoration: BoxDecoration(
            color: HaLanColor.primaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                AppSize.getWidth(context, 24),
              ),
              topLeft: Radius.circular(
                AppSize.getWidth(context, 24),
              ),
            ),
          ),
          child: widget.content,
        ),
      ],
    );
  }
}
