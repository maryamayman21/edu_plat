import 'package:flutter/material.dart';
class ModelAnswerEntity {
  final int examId;
  final String examTitle;
  final List<Map<String, dynamic>> answers;

  ModelAnswerEntity({
    required this.examId,
    required this.examTitle,
    required this.answers,
  });

  factory ModelAnswerEntity.fromJson(Map<String, dynamic> json) {
    return ModelAnswerEntity(
      examId: json['examId'] as int,
      examTitle: json['examTitle'] as String,
      answers: List<Map<String, dynamic>>.from(json['answers'] as List),
    );
  }
}
