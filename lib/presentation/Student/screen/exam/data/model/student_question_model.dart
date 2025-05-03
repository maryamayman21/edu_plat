import 'package:edu_platt/presentation/Student/screen/exam/data/model/student_choice_model.dart';

class StudentQuestionModel {
  final int id;
  final String questionText;
  final int marks;
  final int timeInMin;
  final List<StudentChoiceModel> choices;

  StudentQuestionModel({
    required this.id,
    required this.questionText,
    required this.marks,
    required this.timeInMin,
    required this.choices,
  });

  factory StudentQuestionModel.fromJson(Map<String, dynamic> json) {
    return StudentQuestionModel(
      id: json['id'],
      questionText: json['questionText'],
      marks: json['marks'],
      timeInMin: json['timeInMin'],
      choices: (json['choices'] as List)
          .map((choice) => StudentChoiceModel.fromJson(choice))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionText': questionText,
      'marks': marks,
      'timeInMin': timeInMin,
      'choices': choices.map((choice) => choice.toJson()).toList(),
    };
  }
}
