part of 'offline_exam_bloc.dart';

@immutable
sealed class OfflineExamEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class SetCourseCodeEvent extends OfflineExamEvent{
  final String courseCode;
   SetCourseCodeEvent(this.courseCode);
}
class SetExamTitleEvent extends OfflineExamEvent {
  final String courseTitle;
   SetExamTitleEvent(this.courseTitle);
}

class SetDateEvent extends OfflineExamEvent {
  final DateTime? examDate;
   SetDateEvent (this.examDate);
}
class SetTotalMarkEvent extends OfflineExamEvent {
  final int mark;
   SetTotalMarkEvent  (this.mark);
}
class SetLocationEvent extends OfflineExamEvent {
  final String examLocation;
   SetLocationEvent (this.examLocation);
}
class SetDurationEvent extends OfflineExamEvent {
  final Duration? examDuration;
   SetDurationEvent (this.examDuration);
}
class CreateOfflineExam extends OfflineExamEvent {
  CreateOfflineExam ();
}
class UpdateOfflineExam extends OfflineExamEvent {
  final int examId;
  UpdateOfflineExam (this.examId);
}
class UpdateDoctorOfflineExam extends OfflineExamEvent {
  final int examId;
  UpdateDoctorOfflineExam (this.examId);
}