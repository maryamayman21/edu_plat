import 'package:duration_picker/duration_picker.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/question_bottom_sheet/add_option_button.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/question_bottom_sheet/add_question_mark_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/question_bottom_sheet/option_list_bottomsheet.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/question_bottom_sheet/question_input_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/question_bottom_sheet/save_question_button.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/question_duration_picker.dart';
import 'package:edu_platt/presentation/sharedWidget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddQuestionWidget extends StatefulWidget {
  const AddQuestionWidget({super.key, required this.onlineExamBloc});
  final OnlineExamBloc onlineExamBloc;

  @override
  State<AddQuestionWidget> createState() => _AddQuestionWidgetState();
}

class _AddQuestionWidgetState extends State<AddQuestionWidget> {
  final TextEditingController _questionController = TextEditingController();
  final List<String> _optionTexts = [''];
  String _questionDegree = '';
  int? correctAnswerIndex;
  Duration _duration = const Duration(seconds: 60);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _onCheckboxChanged(int index, bool? value) {
    setState(() {
      if (value == true) {
        correctAnswerIndex = index; // Set the correct answer index
      } else {
        correctAnswerIndex = null; // Unset if unchecked
      }
    });
  }
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
                  QuestionInputField(controller: _questionController),
                  SizedBox(height: 10.h), // Responsive spacing
                  // Options List and Add Option Button
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          OptionsList(
                            optionTexts: _optionTexts,
                            onRemoveOption: (index) {
                              setState(() => _optionTexts.removeAt(index));
                            },
                            onChanged: _onCheckboxChanged,
                            correctAnswerIndex: correctAnswerIndex,
                          ),
                          AddOptionButton(
                            onAddOption: () {
                              setState(() => _optionTexts.add(''));
                            },
                          ),
                          // Question Degree Input Field
                          QuestionDegreeField(
                            questionDegree: _questionDegree,
                            onChanged: (value) => _questionDegree = value,
                          ),
                          // Question Duration Picker
                          QuestionDurationPicker(
                            duration: _duration,
                            onDurationChanged: (val) => setState(() => _duration = val),
                          ),
                          // Save Question Button
                          SaveQuestionButton(
                            formKey: _formKey,
                            questionController: _questionController,
                            optionTexts: _optionTexts,
                            duration: _duration,
                            questionDegree: _questionDegree,
                            onlineExamBloc: widget.onlineExamBloc,
                           correctAnswerIndex: correctAnswerIndex,
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