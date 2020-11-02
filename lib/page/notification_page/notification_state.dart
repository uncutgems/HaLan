part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class ShowNotifications extends NotificationState{
  ShowNotifications(this.notifications);

  final List<NotificationEntity> notifications;
}

class ShowMoreNotifications extends NotificationState{
  ShowMoreNotifications(this.notifications);

  final List<NotificationEntity> notifications;
}

class SeeNotification extends NotificationState{
  SeeNotification(this.checked);

  final bool checked;
}

class LoadingNotification extends NotificationState{}

class FailedToLoadNotification extends NotificationState{
  FailedToLoadNotification(this.message);

  final String message;
}
