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
import 'package:edu_platt/presentation/sharedWidget/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class UpdateOfflineExamView extends StatelessWidget {
  UpdateOfflineExamView({super.key, required this.examId,});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final int examId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DialogCubit>(
          create: (context) => DialogCubit(),
        ),
        BlocProvider(
            create: (context) =>
            OfflineExamBloc(
              doctorExamRepoImp: DoctorExamRepoImp(
                DoctorExamsRemoteDataSourceImpl(ApiService()),
                NetworkInfoImpl(InternetConnectionChecker()),
              ),
              dialogCubit: context.read<DialogCubit>(),
            )
              ..add(UpdateOfflineExam(examId))
        )
      ],
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:  Text('Edit Offline Exam',
            style: TextStyle(
              fontSize: 22.sp, // Slightly smaller for better balance
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
                if(state.isSuccess){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const ExamCreationMessage()),
                  );
                }
              },
              child: BlocBuilder<OfflineExamBloc, OfflineExamState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  else if (state.isDataLoaded) {
                    return Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CourseTitleField(
                              courseTitle:
                              state
                                  .offlineExamModel
                                  .examTitle,
                              onChanged: (value) {
                                context
                                    .read<OfflineExamBloc>().add(
                                    SetExamTitleEvent(value));
                              },

                            ),
                            CourseCodeField(

                              courseCode:
                              state
                                  .offlineExamModel
                                  .courseCode,
                              onChanged: (value) {
                                context
                                    .read<OfflineExamBloc>()
                                    .add(SetCourseCodeEvent(value));
                              },

                            ),
                            ExamLocationField(
                              examLocation: state.offlineExamModel.location,
                              onChanged: (value) {
                                context.read<OfflineExamBloc>().add(
                                    SetLocationEvent(value));
                              },

                            ),


                            QuestionDegreeField(
                              questionDegree: state.offlineExamModel.totalMark
                                  .toString(),
                              onChanged: (value) {
                                context.read<OfflineExamBloc>().add(
                                    SetTotalMarkEvent(int.parse(value)));
                              },
                            ),
                            SizedBox(height: 20.h,),

                            MyDatePicker(
                              date: state
                                  .offlineExamModel
                                  .examDate,
                              onChanged: (value) {
                                context.read<OfflineExamBloc>().add(
                                    SetDateEvent(value));
                              },
                            ),

                            SizedBox(height: 20.h,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: OfflineQuestionDuration(
                                duration: state.offlineExamModel.examDuration,
                              ),
                            ),
                            // QuestionDurationPicker(
                            //   duration: state.offlineExamModel.examDuration,
                            //   onDurationChanged: (value) {
                            //     context.read<OfflineExamBloc>().add(
                            //         SetDurationEvent(value));
                            //   },
                            // ),

                            ActionButton(
                              text: 'Save Changes',
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              iconData: Icons.add,
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) return;
                                context.read<OfflineExamBloc>().add(
                                    UpdateDoctorOfflineExam(examId));
                              },
                            )

                          ],
                        ),
                      ),
                    );
                  }
                  else if(state.isFailure){
                    return Center(child: Text(state.errorMessage));
                  }
                 else { return const Center(child: Text('Something went wrong')); }
                },
              ),
            ),
          )),
    );
  }
}
