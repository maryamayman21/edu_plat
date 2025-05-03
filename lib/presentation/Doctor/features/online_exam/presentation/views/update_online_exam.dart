import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/repo/exam_repository_impl.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/exam_creation_message.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/counter_listview.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/course_code_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/course_title_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/add_question_widget.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/date_picker_widget.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_wigdet_listView.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/custom_elevated_button.dart';
import 'package:edu_platt/presentation/sharedWidget/no_wifi_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class UpdateOnlineExam extends StatefulWidget {
  const UpdateOnlineExam({super.key, required this.examId});
  final int examId;
  @override
  State< UpdateOnlineExam> createState() => _MakeOnlineExamState();
}

class _MakeOnlineExamState extends State< UpdateOnlineExam> {
  DateTime? selectedDate = DateTime.now();
 // String _courseCode = '';
  //String _courseTitle = '';
  DateTime? _examDate = null;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider<DialogCubit>(
      create: (context) => DialogCubit(),
    ),
    BlocProvider(
      create: (context) => OnlineExamBloc(
        doctorExamRepoImp: DoctorExamRepoImp(
          DoctorExamsRemoteDataSourceImpl(ApiService()),
          NetworkInfoImpl(InternetConnectionChecker()),
        ),
        dialogCubit: context.read<DialogCubit>(),
      )..add(UpdateExamEvent(examId: widget.examId)),
),

  ],
  child: Scaffold(
        body: BlocListener<DialogCubit, dynamic>(
          listener: (context, state)async{
            // final dialogCubit = context.read<DialogCubit>();
            if(state == StatusDialog.SUCCESS){
              Navigator.pop(context);
              showSuccessDialog(context);
            }
            if(state == StatusDialog.LOADING){
              showLoadingDialog(context);
            }
            if(state == StatusDialog.FAILURE){
              Navigator.pop(context);
              showErrorDialog(context);
            }
  },
  child: BlocListener<OnlineExamBloc, OnlineExamState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => const ExamCreationMessage()),
              );
            }
            // if (state.errorMessage.isNotEmpty) {
            //   showErrorDialog(context);
            //   context.read<OnlineExamBloc>().add(const ClearErrorMessageEvent());
            // }
          },
          child: BlocBuilder<OnlineExamBloc, OnlineExamState>(
            builder: (context, state) {

              return BlocSelector<OnlineExamBloc, OnlineExamState, List<QuestionModel>>(
                selector: (state) => state.exam.question,
                builder: (context, questions) {
                  if(state.isLoading){
                    return const Center(child: CircularProgressIndicator());
                  }
                  else  if (state.errorMessage.isNotEmpty){
                    return  Center(child: Text(state.errorMessage));
                  }
                  else if(state.errorMessage == 'No internet connection'){
                     return NoWifiWidget(onPressed: () {
                       context.read<OnlineExamBloc>().add(UpdateDoctorExamEvent(examId: widget.examId));
                     });
                  }
                  else {
                    return _buildNonEmptyStateUI(context);
                  }
                },
              );
            },
          ),
        ),
),
      ),
);
  }

  // Widget _buildEmptyStateUI(BuildContext context) {
  //   return Column(
  //     children: [
  //       CourseTitleField(
  //         courseTitle:context.read<OnlineExamBloc>().state.exam.examTitle,
  //         onChanged: (value) {
  //          _courseTitle = value;
  //           context.read<OnlineExamBloc>().add(SetExamCourseTitleEvent(_courseTitle));
  //         },
  //       ), CourseCodeField(
  //         onChanged: (value) {
  //           _courseCode = value;
  //           context.read<OnlineExamBloc>().add(SetExamCourseCodeEvent(_courseCode));
  //         },
  //         courseCode: context.read<OnlineExamBloc>().state.exam.courseCode,
  //       ),
  //       MyDatePicker(
  //         date: context.read<OnlineExamBloc>().state.exam.examDate,
  //         onChanged: (value) {
  //           selectedDate= value;
  //           context.read<OnlineExamBloc>().add(SetExamDateEvent(selectedDate));
  //         },
  //       ),
  //
  //       Expanded(child: Image.asset(AppAssets.nnoNotesFound)),
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: CustomElevatedButton(
  //           onPressed: () => _showQuestionBottomSheet(context),
  //           text: '+ New Question',
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildNonEmptyStateUI(BuildContext context) {
    String _courseCode = context.read<OnlineExamBloc>().state.exam.courseCode;
    String _courseTitle = context.read<OnlineExamBloc>().state.exam.examTitle;
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                title: Text('Update Online Exam',
                  style: TextStyle(
                    fontSize: 22.sp, // Slightly smaller for better balance
                    fontWeight: FontWeight.bold,
                    color: color.primaryColor,
                  ),
                ),
                // toolbarHeight: 100,
                expandedHeight: 290,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      SizedBox(height: 70.h),
                      CourseTitleField(
                        onChanged: (value) {
                          _courseTitle = value;
                        },
                        courseTitle: context.read<OnlineExamBloc>().state.exam.examTitle,
                      ),

                      CourseCodeField(
                        onChanged: (value) {
                          _courseCode = value;
                        },
                        courseCode: context.read<OnlineExamBloc>().state.exam.courseCode,
                      ),
                      MyDatePicker(
                        date:context.read<OnlineExamBloc>().state.exam.examDate,
                        onChanged: (value) {
                          _examDate = value;
                          context.read<OnlineExamBloc>().add(SetExamDateEvent(_examDate));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              context.read<OnlineExamBloc>().state.exam.question.isNotEmpty ?

              SliverPersistentHeader(
                pinned: true,
                delegate: _CounterListHeaderDelegate(
                  child: SizedBox(
                    height: 70,
                    child: CounterListview(
                      noOfQuestion: context.read<OnlineExamBloc>().state.exam.noOfQuestions,
                      totalDegree: context.read<OnlineExamBloc>().state.exam.totalMark,
                      duration: context.read<OnlineExamBloc>().state.exam.examDuration,
                    ),
                  ),
                ),
              ) :  const SliverToBoxAdapter(child: SizedBox.shrink()),
              SliverToBoxAdapter(
                child: SizedBox(height: 30.h),
              ),
              context.read<OnlineExamBloc>().state.exam.question.isNotEmpty ?

              QuestionWidgetListView2(
                questions: context.read<OnlineExamBloc>().state.exam.question,
              ) :  SliverToBoxAdapter(child: Image.asset(AppAssets.nnoNotesFound)),

              SliverToBoxAdapter(
                child: SizedBox(height: 50.h),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            color: Colors.white,
            padding:  EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  onPressed: () => _showQuestionBottomSheet(context),
                  text: '+ New Question',
                ),
                context.read<OnlineExamBloc>().state.exam.question.isNotEmpty ?

                CustomElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    context.read<OnlineExamBloc>().add(SetExamCourseTitleEvent(_courseTitle));
                    context.read<OnlineExamBloc>().add(SetExamCourseCodeEvent(_courseCode));
                    context.read<OnlineExamBloc>().add(UpdateDoctorExamEvent(examId: widget.examId));

                  },
                  text: 'Save Changes',
                ):  const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ],
    );

  }


  void _showQuestionBottomSheet(BuildContext context) {
    final onlineExamBloc = context.read<OnlineExamBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: AddQuestionWidget(onlineExamBloc: onlineExamBloc),
          ),
        );
      },
    );
  }
}

class _CounterListHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _CounterListHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: child,
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}