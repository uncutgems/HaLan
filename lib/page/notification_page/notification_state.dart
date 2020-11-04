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


class LoadingNotifications extends NotificationState{}

class LoadingMoreNotification extends NotificationState{
  LoadingMoreNotification(this.notifications);

  final List<NotificationEntity> notifications;
}

class FailedToLoadNotification extends NotificationState{
  FailedToLoadNotification(this.message);

  final String message;
}
