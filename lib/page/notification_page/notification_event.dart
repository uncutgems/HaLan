part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class CallNotificationAPI extends NotificationEvent{
  CallNotificationAPI(this.page, this.count);

  final int page;
  final int count;
}

class CallMoreNotification extends NotificationEvent{
  CallMoreNotification(this.page, this.count);

  final int page;
  final int count;
}

class ClickOnANotification extends NotificationEvent{
  ClickOnANotification(this.notifications, this.notificationPosition);

  final List<NotificationEntity> notifications;
  final int notificationPosition;
}