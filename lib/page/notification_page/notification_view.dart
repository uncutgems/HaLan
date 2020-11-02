import 'package:avwidget/size_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/model/entity.dart';

import 'notification_bloc.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationBloc notificationBloc = NotificationBloc();

  @override
  void initState() {
    notificationBloc
        .add(CallNotificationAPI(notificationBloc.pageCount, 10));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      cubit: notificationBloc,
      builder: (BuildContext context, NotificationState state) {
        if (state is ShowNotifications) {
          return body(context, state.notifications);
        }
        return Container();
      },
    );
  }

  Widget body(BuildContext context, List<NotificationEntity> notificationList) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Thông báo', style: textTheme.subtitle1,),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: notificationBloc.notifications.length,
            itemBuilder: (BuildContext context, int index) {
              final NotificationEntity notificationEntity = notificationList[index];
              return _notificationBlock(notificationEntity);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notificationBloc.add(
              CallMoreNotification(notificationBloc.pageCount++, 10));
        },
      ),
    );
  }


  Widget _notificationBlock(NotificationEntity notificationEntity) {
    return Container(
      color: notificationEntity.isRead? HaLanColor.white :HaLanColor.lightOrange,
      child: ListTile(
        title: Text('Thông báo',
          //title,
          style: textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          notificationEntity.notificationContent,
          style: textTheme.subtitle1.copyWith(fontWeight: FontWeight.w300),
        ),
        trailing: Text(
          convertTime('dd/MM/yyyy', notificationEntity.createdDate, false),
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
