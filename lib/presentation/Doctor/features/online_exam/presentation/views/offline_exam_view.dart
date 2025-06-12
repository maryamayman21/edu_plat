import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/exam_item_widgets/courses_dropdownmenu.dart';
import 'package:edu_platt/presentation/sharedWidget/no_wifi_widget.dart';
import 'package:edu_platt/presentation/sharedWidget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/repo/exam_repository_impl.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/offline_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/exam_creation_message.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/course_title_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/exam_location_filed.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/offline_question_duration.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/add_question_mark_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/date_picker_widget.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/action_button.dart';

class OfflineExamView extends StatelessWidget {
  OfflineExamView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String totalMarks = '';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DialogCubit()),
        BlocProvider(
          create: (context) => OfflineExamBloc(
            doctorExamRepoImp: DoctorExamRepoImp(
              DoctorExamsRemoteDataSourceImpl(ApiService()),
              NetworkInfoImpl(InternetConnectionChecker()),
            ),
            dialogCubit: context.read<DialogCubit>(),
          )..add(SetUpExamEvent()),
        ),
      ],
      child: Scaffold(
        appBar: _buildAppBar(),
       // bottomNavigationBar: _buildActionButton(context),
        body: MultiBlocListener(
          listeners: [
            BlocListener<DialogCubit, dynamic>(
              listener: _handleDialogState,
            ),
            BlocListener<OfflineExamBloc, OfflineExamState>(
              listener: (context, state) {
                if (state.isSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => const ExamCreationMessage(
                          successMessage: 'Exam has been created successfully.',
                        )),
                  );
                  context.read<OfflineExamBloc>().add( SetSuccessModeEvent());

                }
              },
            ),
          ],
          child: BlocBuilder<OfflineExamBloc, OfflineExamState>(
            builder: (context, state) {
              if(state.isCoursesLoading){
                return const Center(child: CircularProgressIndicator());
              }else if(state.isCoursesSuccess){
                 if(state.registeredCourses.isNotEmpty) {
                   return _buildForm(context, state);
                 }else{
                   return Center(
                       child: Text('No registered courses was found',
                           style: TextStyle(
                             fontSize: 18.sp,
                             fontWeight: FontWeight.w500,
                             color: Colors.grey[700],
                           )));
                 }
              }
              else if(state.isCoursesFailed) {
                if (state.errorMessage == 'No internet connection') {
                  return NoWifiWidget(onPressed: () {
                    context.read<OfflineExamBloc>().add(SetUpExamEvent());
                  });
                }
                else {
                  return TextError(onPressed: () {
                    context.read<OfflineExamBloc>().add( SetUpExamEvent());
                  }, errorMessage: state.errorMessage);
                }
              }else{
                return TextError(onPressed: (){
                  context.read<OfflineExamBloc>().add(SetUpExamEvent());
                }, errorMessage: 'Something went wrong.');
              }
            }
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Make Offline Exam Announcement',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: color.primaryColor,
        ),
      ),
    );
  }

  void _handleDialogState(BuildContext context, dynamic state) {
    switch (state?.status) {
      case StatusDialog.LOADING:
        showLoadingDialog(context);
        break;
      case StatusDialog.SUCCESS:
        Navigator.pop(context);
        showSuccessDialog(context,
            message: state?.message ?? 'Operation successful');
        break;
      case StatusDialog.FAILURE:
        Navigator.pop(context);
        showErrorDialog(context,
            message: state?.message ?? 'Something went wrong');
        break;
    }
  }

  Widget _buildForm(BuildContext context, OfflineExamState state) {
    return Form(
      key: _formKey,
      child:
          Padding(
            padding: EdgeInsets.only(bottom: 80.h), // Space for the button
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CourseTitleField(
                    courseTitle: state.offlineExamModel.examTitle,
                    onChanged: (value) {
                      context.read<OfflineExamBloc>().add(SetExamTitleEvent(value));
                    },
                  ),
                  ExamLocationField(
                    examLocation: state.offlineExamModel.location,
                    onChanged: (value) {
                      context.read<OfflineExamBloc>().add(SetLocationEvent(value));
                    },
                  ),
                  QuestionDegreeField(
                    questionDegree: state.offlineExamModel.totalMark.toString(),
                    onChanged: (value) => totalMarks = value,
                  ),
                  CourseDropdown(
                    selectedCourse: state.offlineExamModel.courseCode,
                    onCourseSelected: (course) {
                      context.read<OfflineExamBloc>().add(SetCourseCodeEvent(course));
                    },
                    courses: state.registeredCourses,
                  ),
                  SizedBox(height: 40.h,),
                  MyDatePicker(
                    date: state.offlineExamModel.examDate,
                    onChanged: (value) {
                      context.read<OfflineExamBloc>().add(SetDateEvent(value));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h),
                    child: OfflineQuestionDuration(
                      duration: state.offlineExamModel.examDuration,
                    ),
                  ),
                  SizedBox(height: 100.h),
                  ActionButton(
                    text: 'Create Exam',
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    iconData: Icons.add,
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;

                      context.read<OfflineExamBloc>().add(SetTotalMarkEvent(int.parse(totalMarks)));
                      context.read<OfflineExamBloc>().add(CreateOfflineExam());
                    },
                  ),// Just to ensure scrolling space
                ],
              ),
            ),
          ),


    );
  }


  Widget _buildActionButton(BuildContext context) {
    return Padding(
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
          if (!_formKey.currentState!.validate()) return;

          context
              .read<OfflineExamBloc>()
              .add(SetTotalMarkEvent(int.parse(totalMarks)));

          context.read<OfflineExamBloc>().add(CreateOfflineExam());
        },
      ),
    );
  }
}
