import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/exam_creation_message.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/counter_listview.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/counter_widget.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/course_code_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/my_time_picker.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/question_bottom_sheet/add_question_widget.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/question_bottom_sheet/date_picker_widget.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/question_widget.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/question_wigdet_listView.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/time_picker.dart';
import 'package:edu_platt/presentation/Student/screen/exam/question/QuestionWidget.dart';
import 'package:edu_platt/presentation/sharedWidget/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeOnlineExam extends StatefulWidget {
  MakeOnlineExam();

  @override
  State<MakeOnlineExam> createState() => _MakeOnlineExamState();
}

class _MakeOnlineExamState extends State<MakeOnlineExam> {
  // Map to store text values instead of controllers
  // final Map<int, List<String>> _optionTexts = {};
  //   bool isEnabled = false;
  DateTime selectedDate = DateTime.now();
  String _courseCode = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnlineExamBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Exam')),
        body: BlocListener<OnlineExamBloc, OnlineExamState>(
       listener: (context, state) {
         if(state.exam.isValid){
       print('Exam created successfully');
        Navigator.push(context, MaterialPageRoute(builder: (c)=>  ExamCreationMessage()));
       }
  },
  child: BlocBuilder<OnlineExamBloc, OnlineExamState>(
          builder: (context, state) {

            if (state.exam.question.isEmpty) {
              // Show a loading indicator or placeholder for the initial state
              return Column(
                children: [
                  CourseCodeField(
                    onChanged:      (value){
                      _courseCode = value;
                      //context.read<OnlineExamBloc>().add(SetExamCourseCodeEvent( value));
                    },
                    courseCode: state.exam.courseCode,
                  ),
                  MyDatePicker(
                    onChanged: (value) {
                      context
                          .read<OnlineExamBloc>()
                          .add(SetExamDateEvent(selectedDate));
                    },
                  ),
                  Expanded(child: Image.asset(AppAssets.nnoNotesFound)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomElevatedButton(
                      onPressed:() => _showQuestionBottomSheet(context),
                      text: '+ New Question',
                    ),
                  ),
                ],

              );
            }

            return Stack(
              children: [
                Form(
                key: _formKey,
                child: CustomScrollView(
                  slivers: [
                    // SliverAppBar for CourseCodeField and MyDatePicker
                    SliverAppBar(
                      expandedHeight: 200, // Adjust height as needed
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          children: [
                            const SizedBox(height: 7),
                            CourseCodeField(
                              onChanged: (value) {
                                _courseCode = value;
                              },
                              courseCode: state.exam.courseCode,
                            ),
                            MyDatePicker(
                              onChanged: (value) {
                                context
                                    .read<OnlineExamBloc>()
                                    .add(SetExamDateEvent(selectedDate));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),


                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _CounterListHeaderDelegate(
                        child: SizedBox(
                          height: 70,
                          child: CounterListview(
                            noOfQuestion: state.exam.noOfQuestions,
                            totalDegree: state.exam.totalDegrees,
                            duration: state.exam.examDuration,
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 30), // Adjust height as needed
                    ),
                    QuestionWidgetListView2(
                    questions: state.exam.question,
                ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 50), // Adjust height as needed
                    ),


                  ],
                ),
              ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.white, // Background color for the buttons
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomElevatedButton(
                          onPressed: () => _showQuestionBottomSheet(context),
                          text: '+ New Question',
                        ),
                        CustomElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;

                            context
                                .read<OnlineExamBloc>()
                                .add(SetExamCourseCodeEvent(_courseCode));
                            context
                                .read<OnlineExamBloc>()
                                .add(CreateExamEvent());
                            if(!state.exam.isValid){
                               showErrorDialog(context);
                            }
                          },
                          text: 'Create Exam',
                        ),
                      ],
                    ),
                  ),
                ),
            ]
            );
          },
        ),
),
      ),
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
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(// Background color for the pinned header
      //height: 70,
      //m: EdgeInsets.only(bottom: 30),
      decoration:  const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),// Background color for the pinned header
      child: child,
    );
  }

  @override
  double get maxExtent => 70; // Height of the CounterListview

  @override
  double get minExtent => 70; // Height of the CounterListview

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}