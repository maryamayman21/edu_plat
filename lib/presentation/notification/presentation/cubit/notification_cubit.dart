import 'package:bloc/bloc.dart';
import 'package:edu_platt/presentation/notification/data/network/request/fetch_notifications_request.dart';
import 'package:edu_platt/presentation/notification/data/repo/notification_repoImp.dart';
import 'package:edu_platt/presentation/notification/domain/entity/notification_entity.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({required this.notificationRepoImp})
      : super(NotificationInitial());
  final NotificationRepoImp notificationRepoImp;

  Future<void> fetchUserNotification() async {
    emit(NotificationLoading());
    final result = await notificationRepoImp
        .fetchUserNotification();
    result.fold((failure) {
      emit(NotificationFailure(errorMessage: failure.message));
    }, (notifications) {
      emit(NotificationSuccess(notificationEntity: notifications));
    });
  }
}
