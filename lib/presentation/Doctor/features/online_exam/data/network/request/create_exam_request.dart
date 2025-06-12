
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';

//for both create / update exam
class CreateExamRequest {
 final BaseExamModel exam;

 CreateExamRequest({required this.exam});

 Map<String, dynamic> toJson() {
  print(exam.examDate);
  return exam.toJson();
 }
}
