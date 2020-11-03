import 'package:avwidget/size_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/size.dart';
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

  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    notificationBloc.add(CallNotificationAPI(notificationBloc.pageCount, 10));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HaLanColor.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HaLanColor.primaryColor,
        title: Text(
          'Thông báo',
          style: textTheme.headline6,
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        cubit: notificationBloc,
        builder: (BuildContext context, NotificationState state) {
          if (state is ShowNotifications) {
            return _someNotification(context, state.notifications);
          }
          return Container();
        },
      ),
    );
  }


  Widget _someNotification(BuildContext context, List<NotificationEntity> notificationList) {
    return Center(
      child: ListView.builder(
          itemCount: notificationBloc.notifications.length,
          itemBuilder: (BuildContext context, int index) {
            final NotificationEntity notificationEntity =
                notificationList[index];
            return _notificationBlock(notificationEntity);
          }),
    );
  }

  Widget _loadFirstNotification(){
    return const CircularProgressIndicator();
  }




  Widget _notificationBlock(NotificationEntity notificationEntity) {
    return Padding(
      padding: EdgeInsets.all(AppSize.getWidth(context, 4)),
      child: Material(
        elevation: 4,
        color: notificationEntity.isRead
            ? HaLanColor.white
            : HaLanColor.primaryLightColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(AVSize.getSize(context, 8)),
        child: Container(
          padding: EdgeInsets.all(AVSize.getSize(context, 8)),
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Thông báo',
                    style: textTheme.subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    convertTime('EEEE dd/MM/yyyy',
                        notificationEntity.createdDate, false),
                    style: textTheme.caption,
                  )
                ],
              ),
              Container(
                height: 4,
              ),
              Text(
                notificationEntity.notificationContent,
                style: textTheme.bodyText2,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
