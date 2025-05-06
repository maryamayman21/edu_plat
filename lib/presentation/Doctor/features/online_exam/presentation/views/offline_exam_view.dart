import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/repo/exam_repository_impl.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/offline_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/exam_creation_message.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/course_code_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/course_title_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/exam_location_filed.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/offline_question_duration.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/add_question_mark_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/date_picker_widget.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_duration_picker.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_duration_widget.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class OfflineExamView extends StatelessWidget {
  OfflineExamView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String totalMarks = '';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<DialogCubit>(
            create: (context) => DialogCubit(),
          ),
          BlocProvider(
            create: (context) => OfflineExamBloc(
              doctorExamRepoImp: DoctorExamRepoImp(
                DoctorExamsRemoteDataSourceImpl(ApiService()),
                NetworkInfoImpl(InternetConnectionChecker()),
              ),
              dialogCubit: context.read<DialogCubit>(),
            ),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Make Offline Exam Announcement',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: color.primaryColor,
              ),
            ),
          ),
          body: BlocListener<DialogCubit, dynamic>(
            listener: (context, state) {
              if (state?.status == StatusDialog.SUCCESS) {
                Navigator.pop(context);
                showSuccessDialog(context, message:   state?.message ?? 'Operation successful' );
              }
              if (state?.status == StatusDialog.LOADING) {
                showLoadingDialog(context);
              }
              if (state?.status == StatusDialog.FAILURE) {
                Navigator.pop(context);
                showErrorDialog(context,  message:   state?.message ?? 'Something went wrong' );
              }
            },
            child: BlocListener<OfflineExamBloc, OfflineExamState>(
              listener: (context, state) {
                if (state.isSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => const ExamCreationMessage()),
                  );
                }
              },
              child: BlocBuilder<OfflineExamBloc, OfflineExamState>(
                builder: (context, state) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            child: IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // All your form fields
                                  CourseTitleField(
                                    courseTitle:
                                        state.offlineExamModel.examTitle,
                                    onChanged: (value) {
                                      context
                                          .read<OfflineExamBloc>()
                                          .add(SetExamTitleEvent(value));
                                    },
                                  ),
                                  SizedBox(height: 12.h),
                                  CourseCodeField(
                                    courseCode:
                                        state.offlineExamModel.courseCode,
                                    onChanged: (value) {
                                      context
                                          .read<OfflineExamBloc>()
                                          .add(SetCourseCodeEvent(value));
                                    },
                                  ),
                                  SizedBox(height: 12.h),
                                  ExamLocationField(
                                    examLocation:
                                        state.offlineExamModel.location,
                                    onChanged: (value) {
                                      context
                                          .read<OfflineExamBloc>()
                                          .add(SetLocationEvent(value));
                                    },
                                  ),
                                  SizedBox(height: 12.h),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: QuestionDegreeField(
                                      questionDegree: state
                                          .offlineExamModel.totalMark
                                          .toString(),
                                      onChanged: (value) {
                                        totalMarks = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  MyDatePicker(
                                    date: state.offlineExamModel.examDate,
                                    onChanged: (value) {
                                      context
                                          .read<OfflineExamBloc>()
                                          .add(SetDateEvent(value));
                                    },
                                  ),
                                  SizedBox(height: 30.h),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: OfflineQuestionDuration(
                                      duration:
                                          state.offlineExamModel.examDuration,
                                    ),
                                  ),
                                  const Spacer(), // Pushes the button to the bottom
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 24.h,
                                      left: 8.w,
                                      right: 8.w,
                                      bottom: 16.h,
                                    ),
                                    child: ActionButton(
                                      text: 'Create Exam',
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.green,
                                      iconData: Icons.add,
                                      onPressed: () {
                                        if (!_formKey.currentState!.validate())
                                          return;
                                        context.read<OfflineExamBloc>().add(
                                            SetTotalMarkEvent(
                                                int.parse(totalMarks)));
                                        context
                                            .read<OfflineExamBloc>()
                                            .add(CreateOfflineExam());
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ));
  }
}
