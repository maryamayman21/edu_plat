import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/notification/data/model/notification_model.dart';

class FetchNotificationResponse extends BaseResponse {
   final List<NotificationModel> notificationModel;
  // ignore: use_super_parameters
  FetchNotificationResponse({required String message, required bool status, required this.notificationModel})
      : super(
    message: message,
    status: status,
  );

  factory FetchNotificationResponse.fromJson(Map<String, dynamic> json) {
    return FetchNotificationResponse(
      message: json['message'] ?? '',
      status: json['success'] ?? false,
      notificationModel: (json['notificationHistory'] as List<dynamic>?)
          ?.map((item) => NotificationModel.fromJson(item))
          .toList() ??
          [],
    );
  }
}
