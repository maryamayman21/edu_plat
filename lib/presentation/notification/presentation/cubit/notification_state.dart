part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}
final class NotificationLoading extends NotificationState {}
final class NotificationSuccess extends NotificationState {
  final List<NotificationEntity> notificationEntity;

  NotificationSuccess({required this.notificationEntity});
}
final class NotificationFailure extends NotificationState {
  final String errorMessage;

  NotificationFailure({required this.errorMessage});

}
