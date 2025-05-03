part of 'pdf_exam_bloc.dart';

class PDFExamState extends Equatable {
  final PDFExamModel exam;
 // final String errorMessage;
  //final bool isLoading;
  final bool isSuccess;
  //final bool isDataLoaded;
  //final bool isFailure;

  const PDFExamState(   {required this.exam , required this.isSuccess});

  factory PDFExamState.initial() {
    return PDFExamState(
        exam: PDFExamModel.initial(),
        // errorMessage : '',
        // isLoading: false,
        isSuccess: false,
        // isDataLoaded: false,
        // isFailure: false
    );
  }

  PDFExamState copyWith({PDFExamModel? exam, bool? isSuccess}) {
    return PDFExamState(
        exam: exam ?? this.exam,
       // errorMessage: errorMessage ?? this.errorMessage,
        //isLoading:  isLoading ?? this.isLoading,
        isSuccess:  isSuccess ?? this.isSuccess,
        //isFailure: isFailure?? this.isFailure,
        //isDataLoaded: isDataLoaded?? this.isDataLoaded

    );
  }

  // Property to check if the state is initial
  bool get isInitial => this == PDFExamState.initial();

  @override
  List<Object?> get props => [exam, isSuccess];
}
