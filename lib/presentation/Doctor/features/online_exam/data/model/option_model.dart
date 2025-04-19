class OptionModel {
  final String text;
  final bool isCorrectAnswer;

  OptionModel({required this.text , this.isCorrectAnswer = false});
  OptionModel copyWith({String? text, bool? isCorrectAnswer}) {
    return OptionModel(
      text: text ?? this.text,
      isCorrectAnswer: isCorrectAnswer ?? this.isCorrectAnswer,
    );
  }

  Map<String, dynamic> toJson() => {'text': text};
}