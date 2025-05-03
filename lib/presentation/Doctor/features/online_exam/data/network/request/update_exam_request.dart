import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';

class UpdateExamRequest{
  final int examId;
  final BaseExamModel exam;
  UpdateExamRequest( {required this.examId, required this.exam});
  Map<String, dynamic> toJson() {
    return exam.toJson();
  }
}