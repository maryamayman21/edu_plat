import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/add_question_mark_field.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionModal extends StatefulWidget {
  const QuestionModal({super.key, });

  @override
  State<QuestionModal> createState() => _QuestionModalState();
}

class _QuestionModalState extends State<QuestionModal> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _subQuestionControllers = [];
  final List<bool> _subQuestionErrors = [];
  int _points = 1;

  @override
  void dispose() {
    for (var controller in _subQuestionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addSubQuestion() {
    setState(() {
      _subQuestionControllers.add(TextEditingController());
      _subQuestionErrors.add(false);
    });
  }

  void _removeSubQuestion(int index) {
    setState(() {
      _subQuestionControllers[index].dispose();
      _subQuestionControllers.removeAt(index);
      _subQuestionErrors.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Add New Question',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
            
                // Sub-questions section
                Text(
                  'Sub-questions:',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
            
                // List of sub-questions
                ..._subQuestionControllers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final controller = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: 'Sub-question ${index + 1}',
                              errorText: _subQuestionErrors[index]
                                  ? 'Please enter sub-question'
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                _subQuestionErrors[index] = true;
                                return '';
                              }
                              _subQuestionErrors[index] = false;
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeSubQuestion(index),
                        ),
                      ],
                    ),
                  );
                }).toList(),
            
                // Add Sub-question button
                OutlinedButton(
                  onPressed: _addSubQuestion,
                  child: const Text('+ Add Sub-question'),
                ),
                const SizedBox(height: 16),
            
                // Points field
                QuestionDegreeField(
                  onChanged: (value) => _points = int.parse(value!),
                  questionDegree: _points.toString(),
                ),
                const SizedBox(height: 24),
            
                // Add Question button
                CustomButtonWidget(
                  child: const Text(
                    'Add Question',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    // Validate all fields
                    bool isValid = _formKey.currentState!.validate();
            
                    // Validate sub-questions
                    for (var i = 0; i < _subQuestionControllers.length; i++) {
                      if (_subQuestionControllers[i].text.isEmpty) {
                        setState(() {
                          _subQuestionErrors[i] = true;
                        });
                        isValid = false;
                      }
                    }
            
                    if (isValid) {
                      Navigator.pop(context, Question(
                        text: 'Question',
                        points: _points,
                        subQuestions: _subQuestionControllers
                            .map((c) => c.text)
                            .toList(),
                      ));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final int points;
  final List<String> subQuestions;

  Question({
    required this.text,
    required this.points,
    required this.subQuestions,
  });
}