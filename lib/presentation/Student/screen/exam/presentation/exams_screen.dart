import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/repo/exam_repoImp.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/bloc/exam_bloc.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/widgets/exam_listview.dart';
import 'package:edu_platt/presentation/sharedWidget/no_wifi_widget.dart';
import 'package:edu_platt/presentation/sharedWidget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
class ExamsScreen extends StatelessWidget {
  const ExamsScreen({super.key, required this.isTaken});
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
        studentExamRepoImp: StudentExamRepoImp(
          StudentExamsRemoteDataSourceImpl(ApiService()),
          NetworkInfoImpl(InternetConnectionChecker()),
        ),
        dialogCubit: context.read<DialogCubit>(),
      )..add(FetchExamsEvent(isExamtaken: isTaken)),
),
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
        body: BlocListener<DialogCubit, DialogState?>(
          listener: (context, state) {
            if (state?.status == StatusDialog.SUCCESS) {
              Navigator.pop(context);
              showSuccessDialog(context, message:state?.message ?? 'Exam has been started!');
            }
            if (state?.status == StatusDialog.LOADING) {
              showLoadingDialog(context,);
            }
            if (state?.status == StatusDialog.FAILURE) {
              Navigator.pop(context);
              showErrorDialog(context, message:state?.message ?? 'Cant start exam, please try later');
            }
          },
  child: BlocListener<ExamBloc, ExamState>(
  listener: (context, state) {
     if(state is ExamLoaded){
       Navigator.pushNamed(context, AppRouters.startExamScreen, arguments: state.exam);
     }
  },
  child: BlocBuilder<ExamBloc, ExamState>(
          builder: (context, state) {
            if (state is ExamLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ExamCardsLoaded) {
              if (state.exams.isEmpty) {
                return Center(child: Image.asset(AppAssets.noDataFound));
              }
              else {
                return ExamListview(examCards: state.exams);
              }
            }
            else if (state is ExamError) {
               if(state.message == 'No internet connection'){
                 return NoWifiWidget(onPressed: () {
                   context
                       .read<ExamBloc>()
                       .add(FetchExamsEvent(isExamtaken: isTaken));
                 });
               }
              else {
                 return TextError(errorMessage: state.message,);
                 //return Center(child: Text(state.message));
               }
              } else {
              return const TextError(errorMessage:'Something went wrong',);
            }
          },
        ),
),
),
      ),
);
  }
}