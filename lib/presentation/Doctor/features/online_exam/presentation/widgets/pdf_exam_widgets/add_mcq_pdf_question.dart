import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/pdf_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/add_option_button.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/add_question_mark_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/question_input_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/option_list_bottom_sheet.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/save_question_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMcqQuestionWidget extends StatefulWidget {
  const AddMcqQuestionWidget({
    super.key,
    required this.pdfExamBloc,
    required this.isWrittenExam
  });

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
  final List<FocusNode> _optionFocusNodes = [FocusNode()];

  @override
  void dispose() {
    _questionController.dispose();
    for (var node in _optionFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Question Input
                  widget.isWrittenExam
                      ? const Text('Add New Question')
                      : QuestionInputField(
                    controller: _questionController,
                    // onFieldSubmitted: (_) {
                    //   if (_optionFocusNodes.isNotEmpty) {
                    //     FocusScope.of(context).requestFocus(_optionFocusNodes[0]);
                    //   }
                    // },
                  ),
              
                  SizedBox(height: 16.h),
              
                  // Options List
                  McqOptionsList(
                    isWritten: widget.isWrittenExam,
                    optionTexts: _optionTexts,
                  //  focusNodes: _optionFocusNodes,
                    onRemoveOption: (index) {
                      setState(() {
                        _optionTexts.removeAt(index);
                        _optionFocusNodes.removeAt(index);
                      });
                    },
                  ),
              
                  // Add Option Button
                  AddOptionButton(
                    isWrittenExam: widget.isWrittenExam,
                    onAddOption: () {
                      if (_optionTexts.length < 5) {
                        setState(() {
                          _optionTexts.add('');
                          _optionFocusNodes.add(FocusNode());
                        });
                      }
                    },
                  ),
              
                  // Question Degree Field (if written exam)
                  if (widget.isWrittenExam)
                    QuestionDegreeField(
                      questionDegree: _questionDegree,
                      onChanged: (value) => _questionDegree = value,
                    ),
              
                  SizedBox(height: 16.h),
              
                  // Save Button
                  McqSaveQuestionButton(
                    formKey: _formKey,
                    questionController: _questionController,
                    optionTexts: _optionTexts,
                    questionDegree: _questionDegree,
                    pdfExamBloc: widget.pdfExamBloc,
                    isWritten: widget.isWrittenExam,
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