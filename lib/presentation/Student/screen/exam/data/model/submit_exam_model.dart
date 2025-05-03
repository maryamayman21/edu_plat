
import 'package:edu_platt/presentation/Student/screen/exam/data/model/submit_question_model.dart';

class SubmitExamModel {
  final int examId;
  final List<SubmitQuestionModel> questionModel;

  SubmitExamModel({required this.examId, required this.questionModel});

  // fromJson factory constructor
  factory SubmitExamModel.fromJson(Map<String, dynamic> json) {
    return SubmitExamModel(
      examId: json['examId'],
      questionModel: (json['questionModel'] as List)
          .map((item) => SubmitQuestionModel.fromJson(item))
          .toList(),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'examId': examId,
      'answers': questionModel.map((q) => q.toJson()).toList(),
    };
  }
}
