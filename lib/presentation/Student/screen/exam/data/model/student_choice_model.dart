class StudentChoiceModel {
  final int id;
  final String text;

  StudentChoiceModel({required this.id, required this.text});

  factory StudentChoiceModel.fromJson(Map<String, dynamic> json) {
    return StudentChoiceModel(
      id: json['id'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }
}
