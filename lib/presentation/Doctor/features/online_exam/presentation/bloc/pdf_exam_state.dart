part of 'pdf_exam_bloc.dart';

class PDFExamState extends Equatable {
  final PDFExamModel exam;
  final String errorMessage;
  final bool isLoading;
  final bool isSuccess;
  final bool isDataLoaded;
  final bool isFailure;
  final bool isExamDataFailure;
  final bool isExamDataLoaded;
  final List<String> courses;

  const PDFExamState({ required this.isExamDataLoaded, required this.errorMessage, required this.isLoading, required this.isDataLoaded, required this.isFailure, required this.exam , required this.isSuccess ,required this.courses, required this.isExamDataFailure});

  factory PDFExamState.initial() {
    return PDFExamState(
        exam: PDFExamModel.initial(),
         errorMessage : '',
         isLoading: false,
         isSuccess: false,
         isDataLoaded: false,
         isFailure: false,
      isExamDataLoaded: false,
      courses: [],
      isExamDataFailure: false
    );
  }

  PDFExamState copyWith({PDFExamModel? exam, bool? isSuccess , bool? isLoading ,bool? isDataLoaded  , bool? isFailure , String? errorMessage, List<String>? courses, bool? isExamDataLoaded, bool? isExamDataFailure}) {
    return PDFExamState(
        exam: exam ?? this.exam,
        errorMessage: errorMessage ?? this.errorMessage,
        isLoading:  isLoading ?? this.isLoading,
        isSuccess:  isSuccess ?? this.isSuccess,
        isFailure: isFailure?? this.isFailure,
        isDataLoaded: isDataLoaded?? this.isDataLoaded,
      courses:  courses?? this.courses,
      isExamDataLoaded: isExamDataLoaded?? this.isExamDataLoaded,
      isExamDataFailure : isExamDataFailure??this.isExamDataFailure

    );
  }

  // Property to check if the state is initial
  bool get isInitial => this == PDFExamState.initial();

  @override
  List<Object?> get props => [exam, isSuccess, isFailure , isLoading , isDataLoaded, errorMessage, courses, isExamDataLoaded, isExamDataFailure
  ];
}
