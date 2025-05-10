import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/notification/data/data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/notification/data/repo/notification_repoImp.dart';
import 'package:edu_platt/presentation/notification/presentation/cubit/notification_counter_cubit.dart';
import 'package:edu_platt/presentation/notification/presentation/cubit/notification_cubit.dart';
import 'package:edu_platt/presentation/notification/presentation/widgets/notification_tile.dart';
import 'package:edu_platt/services/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() => _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCounterCubit>().reset();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationCubit(
        notificationRepoImp: NotificationRepoImp(
          notificationRemoteDataSource:
          NotificationRemoteDataSourceImp(apiService:  ApiService()),
        networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
      ))..fetchUserNotification(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notifications', style: TextStyle(fontSize: 20.sp)),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NotificationSuccess) {
                if (state.notificationEntity.isEmpty) {
                  return Center(
                    child: Text('No notifications yet.', style: TextStyle(fontSize: 16.sp)),
                  );
                }

                return ListView.separated(
                  itemCount: state.notificationEntity.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    return NotificationTile(notification: state.notificationEntity[index]);
                  },
                );
              } else if (state is NotificationFailure) {
                return Center(
                  child: Text(state.errorMessage, style: TextStyle(fontSize: 16.sp, color: Colors.red)),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
