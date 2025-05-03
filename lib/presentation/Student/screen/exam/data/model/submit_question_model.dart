class SubmitQuestionModel {
  final int answerId;
  final int selectedChoiceId;

  SubmitQuestionModel({required this.answerId, required this.selectedChoiceId});

  // fromJson factory constructor
  factory SubmitQuestionModel.fromJson(Map<String, dynamic> json) {
    return SubmitQuestionModel(
      answerId: json['questionId'],
      selectedChoiceId: json['selectedChoiceId'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'questionId': answerId,
      'selectedChoiceId': selectedChoiceId,
    };
  }
}
