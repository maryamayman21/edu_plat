import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/model/submit_exam_model.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/repo/exam_repoImp.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/bloc/exam_bloc.dart';
import 'package:edu_platt/presentation/sharedWidget/no_wifi_widget.dart';
import 'package:edu_platt/presentation/sharedWidget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class QuizResultScreen extends StatelessWidget {
  final SubmitExamModel exam;

  const QuizResultScreen({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DialogCubit()),
        BlocProvider(
          create: (context) => ExamBloc(
            studentExamRepoImp: StudentExamRepoImp(
              StudentExamsRemoteDataSourceImpl(ApiService()),
              NetworkInfoImpl(InternetConnectionChecker()),
            ),
            dialogCubit: context.read<DialogCubit>(),
          )..add(SubmitExamScore(exam)),
        ),
      ],
      child: Scaffold(
        backgroundColor: color.primaryColor,
        body: BlocBuilder<ExamBloc, ExamState>(
          builder: (context, state) {
            if (state is ExamSuccess) return _buildSuccessContent(state, context);
            if (state is ExamError) return _buildErrorContent(context, state);
            if (state is ExamLoading) return const Center(child: CircularProgressIndicator());
            return _buildDefaultError(context);
          },
        ),
      ),
    );
  }

  Widget _buildSuccessContent(ExamSuccess state, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.celebration, size: 80.sp, color: Colors.yellow),
          SizedBox(height: 20.h),
          Text(
            state.successMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
          _buildBackButton(context),
        ],
      ),
    );
  }

  Widget _buildErrorContent(BuildContext context, ExamError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state.message == 'No internet connection')
            NoWifiWidget(
              onPressed: () {
                context.read<ExamBloc>().add(SubmitExamScore(exam));
              },
            )
          else
            TextError(
              isnotTry: true,
              errorMessage: state.message,
              white: true,
              onPressed: () {
                context.read<ExamBloc>().add(SubmitExamScore(exam));
              },
            ),
          SizedBox(height: 20.h),
          _buildBackButton(context),
        ],
      ),
    );
  }

  Widget _buildDefaultError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextError(
            errorMessage: 'Something went wrong',
            white: true,
            onPressed: () {
              context.read<ExamBloc>().add(SubmitExamScore(exam));
            },
          ),
          SizedBox(height: 20.h),
          _buildBackButton(context),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouters.HomeStudent,
                (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          minimumSize: Size(double.infinity, 50.h), // Full-width button
        ),
        child: Text(
          "Back to Home",
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}