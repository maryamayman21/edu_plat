import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/option_model.dart';

class QuestionModel {
  final String question;
  final int degree;
  final Duration questionDuration;
  final List<OptionModel> options;
   bool isValid;


  QuestionModel( {required this.question, required this.options, required this.degree,  required this.questionDuration,this.isValid = true});

  QuestionModel copyWith({String? question, List<OptionModel>? options, int? degree , Duration? duration, bool? isValid}) {
    return QuestionModel(
      question: question ?? this.question,
      options: options ?? this.options,
       degree : degree?? this.degree,
      questionDuration: duration ?? this.questionDuration,
      isValid: isValid ?? this.isValid

    );
  }
}
