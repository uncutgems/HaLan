import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/notification_repository.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial());
  int pageCount = 0;

  final NotificationRepository _notificationRepository =
      NotificationRepository();

  List<NotificationEntity> notifications = <NotificationEntity>[];

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is CallNotificationAPI) {
      yield* _mapCallNotificationAPIToState(event);
    } else if (event is CallMoreNotification) {
      yield* _mapCallMoreNotification(event);
    }
  }

  Stream<NotificationState> _mapCallNotificationAPIToState(
      CallNotificationAPI event) async* {
    try {
      yield LoadingNotifications();
      final List<NotificationEntity> displayList = await _notificationRepository
          .showNotification(event.page, event.count);
      notifications = displayList;
      // notifications.add(null);
      yield ShowNotifications(notifications);
    } on APIException catch (e) {
      yield FailedToLoadNotification(e.message());
    }
  }

  Stream<NotificationState> _mapCallMoreNotification(
      CallMoreNotification event) async* {
    try {
      yield LoadingMoreNotification(notifications);
      pageCount++;
      final List<NotificationEntity> displayList = await _notificationRepository
          .showNotification(event.page + 1, event.count);
      notifications.removeLast();
      notifications.addAll(displayList);
      notifications.add(null);
      yield ShowMoreNotifications(notifications);
    } on APIException catch (e) {
      yield FailedToLoadNotification(e.message());
    }
  }
}
