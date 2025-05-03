import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/pdf_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/date_picker_widget.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/course_code_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/course_title_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/level_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/program_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/semester_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/time_filed.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/total_mark_field.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PdfMcqFormExam extends StatefulWidget {
  const PdfMcqFormExam({super.key, required this.isWrittenExam});
  final bool isWrittenExam;
  @override
  State<PdfMcqFormExam> createState() => _PdfMcqFormExamState();
}

class _PdfMcqFormExamState extends State<PdfMcqFormExam> {
  String _courseTitle = '';
  String _courseCode = '';
  String _timeInHours = '';
  String _level = '';
  String _semester = '';
  String _totalMark = '';
  String _program = '';
  DateTime? _examDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PDFExamBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Create PDF MCQ Exam',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CourseTitleField(
                  courseTitle: _courseTitle,
                  onChanged: (value) {
                    _courseTitle = value;
                  },
                ),
                CourseCodeField(
                  onChanged: (value) {
                    _courseCode = value;
                  },
                  courseCode: _courseCode,
                ),
                TimeFiled(
                  timeInHour: _timeInHours,
                  onChanged: (value) => _timeInHours = value,
                ),
                TotalMarkField(
                  totalMark: _totalMark,
                  onChanged: (value) => _totalMark = value,
                ),
                LevelField(
                  level: _level,
                  onChanged: (value) => _level = value,
                ),
                SemesterField(
                  semester: _semester,
                  onChanged: (value) => _semester = value,
                ),
                ProgramField(
                  program: _program,
                  onChanged: (value) => _program = value,
                ),
                MyDatePicker(
                  date: _examDate,
                  onChanged: (value) {
                    _examDate = value;
                    // context.read<OnlineExamBloc>().add(SetExamDateEvent(selectedDate));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<PDFExamBloc, PDFExamState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final pdfExamBloc = context.read<PDFExamBloc>();

                            ///TODO:: SET VARIABLES AND NAVIGATE TO QUESTION SCREEN
                            pdfExamBloc.add(SetExamDataEvent(
                                timeInHour: _timeInHours,
                                totalMark: int.parse(_totalMark),
                                courseCode: _courseCode,
                                level: _level,
                                program: _program,
                                semester: _semester,
                                examDate: _examDate,
                                courseTitle: _courseTitle));
                            widget.isWrittenExam
                                ? Navigator.pushNamed(
                                    context,
                                    AppRouters.pdfSetQuestionScreen,
                                    arguments: {
                                      'isWrittenExam': true, // or true
                                      'bloc': pdfExamBloc,
                                    },
                                  )
                                : Navigator.pushNamed(
                                    context,
                                    AppRouters.pdfSetQuestionScreen,
                                    arguments: {
                                      'isWrittenExam': false, // or true
                                      'bloc': pdfExamBloc,
                                    },
                                  );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please review your inputs')),
                            );
                          }
                        },
                        text: 'Set Questions',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
