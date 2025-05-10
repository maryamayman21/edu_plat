import 'package:dartz/dartz.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/presentation/notification/data/network/request/fetch_notifications_request.dart';
import 'package:edu_platt/presentation/notification/domain/entity/notification_entity.dart';

abstract class NotificationRepo{
  Future<Either<Failure, List<NotificationEntity>>> fetchUserNotification();
}