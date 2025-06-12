import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/repo/exam_repository_impl.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/pdf_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/exam_item_widgets/cousre_grid_item.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/sharedWidget/no_wifi_widget.dart';
import 'package:edu_platt/presentation/sharedWidget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SelectCourseView extends StatelessWidget {
  const SelectCourseView({super.key, required this.isWrittenExam});

  final bool isWrittenExam;

   @override
   Widget build(BuildContext context) {
     return BlocProvider(
       create: (context) => PDFExamBloc(
          doctorExamRepoImp: DoctorExamRepoImp(
        DoctorExamsRemoteDataSourceImpl(ApiService()),
        NetworkInfoImpl(InternetConnectionChecker()),
        )
      )
        ..add(const SetUpExamEvent()),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: BlocBuilder<PDFExamBloc, PDFExamState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.isFailure) {
                if (state.errorMessage == 'No internet connection') {
                  return NoWifiWidget(onPressed: () {
                    context.read<PDFExamBloc>().add(const SetUpExamEvent());
                  });
                } else {
                  return TextError(
                      onPressed: () {
                        context.read<PDFExamBloc>().add(const SetUpExamEvent());
                      },
                      errorMessage: state.errorMessage);
                }
              } else if (state.isDataLoaded) {
                if (state.courses.isNotEmpty) {
                  return _buildSelectCourseContent(context, state.courses);
                } else {
                  return Center(
                      child: Text('No registered courses was found',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          )));
                }
              } else {
                return TextError(
                    onPressed: () {
                      context.read<PDFExamBloc>().add(const SetUpExamEvent());
                    },
                    errorMessage: 'Something went wrong.');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSelectCourseContent(BuildContext context, List<String> courses) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.h),
          SizedBox(
            height: 250,
            width: 250,
            child: Image.asset(AppAssets.createExam, fit: BoxFit.cover),
          ),
          SizedBox(height: 20.h),
          Text(
            'Please select a course to start setting exam questions.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 30.h),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: courses.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ScreenUtil().screenWidth > 600 ? 4 : 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              return CourseGridItem(
                  title: courses[index],
                  onTap: () {

                     Navigator.pushNamed(
                                     context,
                                     AppRouters.pdfSetQuestionScreen,
                                     arguments: {
                                       'isWrittenExam': isWrittenExam,
                                       'bloc': context.read<PDFExamBloc>(),
                                       'courseCode': courses[index]
                                    },
                                  );
                    //NAVIGATION TO QUESTION SCREEN WITH PASSING COURSE CODE
                  });
            },
          ),
        ],
      ),
    );
  }
}
