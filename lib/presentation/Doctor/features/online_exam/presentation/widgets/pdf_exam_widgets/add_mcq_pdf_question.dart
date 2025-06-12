import 'package:duration_picker/duration_picker.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/pdf_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/add_option_button.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/add_question_mark_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/option_list_bottomsheet.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/question_input_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/save_question_button.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_duration_picker.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/option_list_bottom_sheet.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/save_question_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMcqQuestionWidget extends StatefulWidget {
  const AddMcqQuestionWidget({super.key, required this.pdfExamBloc, required this.isWrittenExam});
  final PDFExamBloc pdfExamBloc;
  final bool isWrittenExam;
  @override
  State<AddMcqQuestionWidget> createState() => _AddMcqQuestionWidgetState();
}

class _AddMcqQuestionWidgetState extends State<AddMcqQuestionWidget> {
  final TextEditingController _questionController = TextEditingController();
  final List<String> _optionTexts = [''];
  String _questionDegree = '';


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.all(16.r), // Responsive padding
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7, // 70% of screen height
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Question Input Field
                 widget.isWrittenExam ?  const Text('Add New Question') :  QuestionInputField(controller: _questionController) ,
                  SizedBox(height: 10.h), // Responsive spacing
                  // Options List and Add Option Button
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          McqOptionsList(
                            isWritten: widget.isWrittenExam,
                            optionTexts: _optionTexts,
                            onRemoveOption: (index) {
                              setState(() => _optionTexts.removeAt(index));
                            },
                          ),
                          AddOptionButton(
                            isWrittenExam: widget.isWrittenExam,
                            onAddOption: () {
                              if(_optionTexts.length < 6) {
                                setState(() => _optionTexts.add(''));
                              }
                            },
                          ),
                          // Question Degree Input Field
                           widget.isWrittenExam?
                          QuestionDegreeField(
                            questionDegree: _questionDegree,
                            onChanged: (value) => _questionDegree = value,
                          ) : const SizedBox.shrink(),
                          // Question Duration Picker
                          // Save Question Button
                            SizedBox(
                              height: 40.h,
                            ),
                          McqSaveQuestionButton(
                            formKey: _formKey,
                            questionController: _questionController,
                            optionTexts: _optionTexts,
                            questionDegree: _questionDegree,
                            pdfExamBloc: widget.pdfExamBloc,

                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}