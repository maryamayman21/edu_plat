import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/option_model.dart';

class QuestionModel {
  final String question;
  final int? degree;
  final Duration? questionDuration;
  final List<OptionModel> options;
  bool isValid;

  QuestionModel({
    required this.question,
    required this.options,
     this.degree = 0,
    this.questionDuration,
    this.isValid = true,
  });

  QuestionModel copyWith({
    String? question,
    List<OptionModel>? options,
    int? degree,
    Duration? duration,
    bool? isValid,
  }) {
    return QuestionModel(
      question: question ?? this.question,
      options: options ?? this.options,
      degree: degree ?? this.degree,
      questionDuration: duration ?? this.questionDuration,
      isValid: isValid ?? this.isValid,
    );
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['questionText'] ,
      degree: json['marks'],
      questionDuration: Duration(minutes: json['timeInMin']),
      options: (json['choices'] as List)
          .map((opt) => OptionModel.fromJson(opt))
          .toList(),
      isValid: json['isValid'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionText': question,
      'marks': degree,
      'timeInMin': questionDuration!.inMinutes,
      'choices': options.map((opt) => opt.toJson()).toList(),
     // 'isValid': isValid,
    };
  }
}
