import 'package:avwidget/size_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tool.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _notificationBlock(String title, String subtitle, int time) {
    return ListTileTheme(

      child: ListTile(
        title: Text(
          title,
          style: textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: textTheme.subtitle1.copyWith(fontWeight: FontWeight.w300),
        ),
        trailing: Text(
          convertTime('dd/MM/yyyy', time, false),
          style: textTheme.subtitle2
              .copyWith(fontWeight: FontWeight.w300, color: HaLanColor.gray60),
        ),
        onTap: (){},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AVSize.getSize(context, 8)),
        ),
      ),
    );
  }
}
