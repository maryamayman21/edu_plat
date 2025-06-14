import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/repo/exam_repository_impl.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/exam_item_widgets/student_card.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/bloc/screenshot_bloc.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:no_screenshot/no_screenshot.dart';

class ViewStudentDegreesView extends StatelessWidget {
   ViewStudentDegreesView({super.key, required this.examId});

  final int examId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DialogCubit>(
          create: (context) => DialogCubit(),
        ),
        // BlocProvider(
        //   create: (context) => ScreenshotBloc()..add(EnableSecureMode()),
        // ),
        BlocProvider(
          create: (context) => ExamBloc(
            dialogCubit: context.read<DialogCubit>(),
            doctorExamRepoImp: DoctorExamRepoImp(
              DoctorExamsRemoteDataSourceImpl(ApiService()),
              NetworkInfoImpl(InternetConnectionChecker()),
            ),
          )..add(GetStudentDegrees(examId)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Student Degrees',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: color.primaryColor,
            ),
          ),
        ),
        body: BlocBuilder<ExamBloc, ExamState>(
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: _buildContent(state),
                ),
                if (state is StudentDegreesLoaded)
                  _bottomPdfButton(state, context), // Only shows on success
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(ExamState state) {
    if (state is ExamLoading) {
      return _loadingContent();
    } else if (state is StudentDegreesLoaded) {
      return _contentSuccess(state);
    } else if (state is ExamError) {
      return _contentError(state);
    }
    return const Center(child: Text('No data available'));
  }

  Widget _loadingContent() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _contentSuccess(StudentDegreesLoaded state) {
    return ListView.builder(
      itemCount: state.studentDegrees.length,
      itemBuilder: (context, index) {
        return StudentCard(student: state.studentDegrees[index]);
      },
    );
  }

  Widget _contentError(ExamError state) {
    return Center(
      child: Text(
        state.message,
        style: TextStyle(fontSize: 16.sp),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _bottomPdfButton(StudentDegreesLoaded state , BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 75,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: ActionButton(
          text: 'Convert to PDF',
          onPressed: () {
            Navigator.pushNamed(context, AppRouters.pdfStudentDegreesScreen, arguments: state.studentDegrees );
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          iconData: Icons.picture_as_pdf_outlined,
        ),
      ),
    );
  }
}
