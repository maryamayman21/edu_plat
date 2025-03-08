

part of 'online_exam_bloc.dart';

class OnlineExamState extends Equatable {
  final ExamModel exam;

  const OnlineExamState({required this.exam});

  factory OnlineExamState.initial() {
    return OnlineExamState(
      exam: ExamModel.initial(),
    );
  }

  OnlineExamState copyWith({ExamModel? exam}) {
    return OnlineExamState(
      exam: exam ?? this.exam,
    );
  }

  // Property to check if the state is initial
  bool get isInitial => this == OnlineExamState.initial();

  @override
  List<Object?> get props => [exam];
}
