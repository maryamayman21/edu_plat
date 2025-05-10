import 'package:edu_platt/presentation/notification/domain/entity/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required String title,
    required String body,
    required String date,
  }) : super(
    title: title,
    body: body,
    date: date,
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title:json['title'] ?? '',
      body: json['body'] ?? '',
      date: json['sentAt'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'date': date,
    };
  }
}
