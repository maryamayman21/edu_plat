import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/custom_dialogs.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/repo/exam_repository_impl.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/exam_item_widgets/offline_exam_card.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/exam_item_widgets/online_exam_card.dart';
import 'package:edu_platt/presentation/sharedWidget/no_wifi_widget.dart';
import 'package:edu_platt/presentation/sharedWidget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ExamsView extends StatelessWidget {
  const ExamsView({super.key, required this.isTaken});
  final bool isTaken;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DialogCubit>(
          create: (context) => DialogCubit(),
        ),
        BlocProvider(
          create: (context) => ExamBloc(
            dialogCubit: context.read<DialogCubit>(),
            doctorExamRepoImp: DoctorExamRepoImp(
              DoctorExamsRemoteDataSourceImpl(ApiService()),
              NetworkInfoImpl(InternetConnectionChecker()),
            ),
          )..add(FetchExamsEvent(isExamtaken: isTaken)),
        )
      ],
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              isTaken ? 'Recent Exams' : 'Upcoming Exams',
              style: TextStyle(
                fontSize: 22.sp, // Slightly smaller for better balance
                fontWeight: FontWeight.bold,
                color: color.primaryColor,
              ),
            ),
            centerTitle: true,
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
            child: BlocBuilder<ExamBloc, ExamState>(
              builder: (context, state) {
                if (state is ExamLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ExamsIsEmpty) {
                  return Center(child: Image.asset(AppAssets.noDataFound));
                } else if (state is ExamLoaded) {
                  return ListView.builder(
                      itemCount: state.exams.length,
                      itemBuilder: (context, index) {
                        final exam = state.exams[index];

                        if (exam.isOnline) {
                          return OnlineExamCard(
                            onPressed: () async {
                              bool? isConfirmed =
                                  await CustomDialogs.showConfirmationDialog(
                                      context: context,
                                      title: 'Alert',
                                      content:
                                          'Are you sure to delete ${exam.examTitle}',
                                      imageUrl: AppAssets.trashBin);
                              if (isConfirmed != null && isConfirmed) {
                                context.read<ExamBloc>().add(DeleteExam(
                                    exam.examId, exam.isExamFinished));
                              }
                            },
                            examEntity: exam,
                          );
                        } else{
                          return OfflineExamCard(
                            onPressed: () async {
                              bool? isConfirmed =
                              await CustomDialogs.showConfirmationDialog(
                                  context: context,
                                  title: 'Alert',
                                  content:
                                  'Are you sure to delete ${exam.examTitle}',
                                  imageUrl: AppAssets.trashBin);
                              if (isConfirmed != null && isConfirmed) {
                                context.read<ExamBloc>().add(DeleteExam(
                                    exam.examId, exam.isExamFinished));
                              }
                            },
                            examEntity: exam,
                          );
                        }
                      });
                } else if (state is ExamError) {
                  return TextError(
                    errorMessage: state.message,
                      onPressed: () {
                        context
                            .read<ExamBloc>()
                            .add(FetchExamsEvent(isExamtaken: isTaken));
                      }
                  );
                } else if (state is ExamsNoWifi) {
                  return NoWifiWidget(
                      onPressed: () {
                    context
                        .read<ExamBloc>()
                        .add(FetchExamsEvent(isExamtaken: isTaken));
                  });
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              },
            ),
          )),
    );
  }
}
