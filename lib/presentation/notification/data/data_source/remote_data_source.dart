import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/presentation/notification/data/network/response/fetch_notifications_response.dart';

abstract class  NotificationRemoteDataSource{
  Future<FetchNotificationResponse> fetchUserNotifications();

}

class  NotificationRemoteDataSourceImp implements NotificationRemoteDataSource{
  final ApiService apiService;
  NotificationRemoteDataSourceImp({required this.apiService});
  @override
  Future<FetchNotificationResponse> fetchUserNotifications()async {
    var response = await  apiService.getFromUrl(endPoint: ApiConstants.getUserNotificationEndpoint);
    return FetchNotificationResponse.fromJson(response.data);
  }

}