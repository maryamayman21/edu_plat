import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/notification/data/data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/notification/data/network/request/fetch_notifications_request.dart';
import 'package:edu_platt/presentation/notification/data/network/response/fetch_notifications_response.dart';
import 'package:edu_platt/presentation/notification/domain/entity/notification_entity.dart';
import 'package:edu_platt/presentation/notification/domain/repo/notification_repo.dart';

class NotificationRepoImp implements NotificationRepo{

  final NotificationRemoteDataSource  notificationRemoteDataSource;
 final  NetworkInfo networkInfo;
  NotificationRepoImp({required this.networkInfo, required this.notificationRemoteDataSource});

  @override
  Future<Either<Failure, List<NotificationEntity>>> fetchUserNotification()async {
    if (await networkInfo.isConnected) {
      try {
        FetchNotificationResponse response =
            await notificationRemoteDataSource.fetchUserNotifications();
        if (response.status == true) {
          return right(response.notificationModel ?? []);
        } else {
          return left(
              ServerFailure(response.message ?? 'Something went wrong'));
        }
      } catch (e) {
        if (e is DioError) {
          return left(ServerFailure.fromDiorError(e));
        }
        return left(ServerFailure(e.toString()));
      }
    } else {
      return left(ServerFailure('No internet connection'));
    }
  }



}