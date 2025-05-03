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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeOnlineExam extends StatefulWidget {
  const MakeOnlineExam({super.key});

  @override
  State<MakeOnlineExam> createState() => _MakeOnlineExamState();
}

class _MakeOnlineExamState extends State<MakeOnlineExam> {
  DateTime selectedDate = DateTime.now();
  String _courseCode = '';
  String _courseTitle = '';
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
      create: (context) =>  OnlineExamBloc(
        doctorExamRepoImp: DoctorExamRepoImp(
          DoctorExamsRemoteDataSourceImpl(ApiService()),
          NetworkInfoImpl(InternetConnectionChecker()),
        ),
        dialogCubit: context.read<DialogCubit>(),
      ),
),
  ],
  child: Scaffold(
        body: BlocListener<OnlineExamBloc, OnlineExamState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => const ExamCreationMessage()),
              );
            }
            if (state.isLoading) {
              showLoadingDialog(context);
            }
            if (state.errorMessage.isNotEmpty) {
             Navigator.pop(context);
              showErrorDialog(context);
              context.read<OnlineExamBloc>().add(const ClearErrorMessageEvent());
            }
          },
          child: BlocBuilder<OnlineExamBloc, OnlineExamState>(
         builder: (context, state) {
         return BlocSelector<OnlineExamBloc, OnlineExamState, List<QuestionModel>>(
            selector: (state) => state.exam.question,
            builder: (context, questions) {
                return _buildNonEmptyStateUI(context);
            },
          );
  },
),
        ),
      ),
);
  }

  Widget _buildNonEmptyStateUI(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                    centerTitle: true,
                    title: Text('Create Online Exam',
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
                        courseTitle:  _courseTitle,
                      ),

                      CourseCodeField(
                        onChanged: (value) {
                          _courseCode = value;
                        },
                        courseCode: _courseCode,
                      ),
                      MyDatePicker(
                        date: _examDate,
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
            padding:  const EdgeInsets.all(8.0),
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
                    print(selectedDate);
                    context.read<OnlineExamBloc>().add(SetExamCourseTitleEvent(_courseTitle));
                    context.read<OnlineExamBloc>().add(SetExamCourseCodeEvent(_courseCode));
                    context.read<OnlineExamBloc>().add(const CreateExamEvent());
                  },
                  text: 'Create Online Exam',
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