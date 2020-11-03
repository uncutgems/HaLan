import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/notification_repository.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial());
  int pageCount = 0;
  
  final NotificationRepository _notificationRepository = NotificationRepository();

  List<NotificationEntity> notifications = <NotificationEntity>[];
  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is CallNotificationAPI){
      // yield LoadingNotification();
      final List<NotificationEntity> displayList = await _notificationRepository.showNotification(event.page, event.count);
      notifications = displayList;
      yield ShowNotifications(notifications);
    }
    if(event is CallMoreNotification){
      yield LoadingNotification();
      pageCount++;
      final List<NotificationEntity> displayList = await _notificationRepository.showNotification(event.page + 1, event.count);
      notifications.addAll(displayList);
      yield ShowMoreNotifications(notifications);
    }
  }
}
