class OptionModel {
  final String text;
  final bool isCorrectAnswer;

  OptionModel({required this.text, this.isCorrectAnswer = false});

  OptionModel copyWith({String? text, bool? isCorrectAnswer}) {
    return OptionModel(
      text: text ?? this.text,
      isCorrectAnswer: isCorrectAnswer ?? this.isCorrectAnswer,
    );
  }

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      text: json['choiceText'],
      isCorrectAnswer: json['isCorrect'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'choiceText': text,
      'isCorrect': isCorrectAnswer,
    };
  }
}