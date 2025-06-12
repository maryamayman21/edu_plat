

part of 'online_exam_bloc.dart';

class OnlineExamState extends Equatable {
  final OnlineExamModel exam;
  final String errorMessage;
  final bool isLoading;
  final bool isCoursesLoading;
  final bool isCoursesFailed;
  final bool isCoursesSuccess;
  final bool isSuccess;
  final bool isDataLoaded;
  final bool isFailure;
  final List<String> registeredCourses;
  final String validationMessage;

  const OnlineExamState({required this.isCoursesLoading, required this.isCoursesFailed, required this.isCoursesSuccess, required this.exam, required this.errorMessage,required this.isLoading,  required this.isSuccess, required this.isDataLoaded, required this.isFailure, required this.validationMessage, required this.registeredCourses });

  factory OnlineExamState.initial() {
    return OnlineExamState(
      exam: OnlineExamModel.initial(),
      errorMessage : '',
       validationMessage: '',
       registeredCourses: [],
       isLoading: false,
        isSuccess: false,
         isDataLoaded: false,
         isFailure: false,
      isCoursesFailed: false,
      isCoursesLoading: false,
      isCoursesSuccess: false,
    );
  }

  OnlineExamState copyWith({OnlineExamModel? exam, String? errorMessage,String? validationMessage , bool? isLoading , bool? isSuccess , bool? isDataLoaded ,bool? isFailure, List<String>? registeredCourses, bool? isCoursesSuccess, bool? isCoursesLoading, bool? isCoursesFailed}) {
    return OnlineExamState(
      exam: exam ?? this.exam,
      validationMessage:  validationMessage ?? this.validationMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading:  isLoading ?? this.isLoading,
      isSuccess:  isSuccess ?? this.isSuccess,
      isFailure: isFailure?? this.isFailure,
      isDataLoaded: isDataLoaded?? this.isDataLoaded,
      registeredCourses: registeredCourses?? this.registeredCourses,
      isCoursesSuccess: isCoursesSuccess?? this.isCoursesSuccess,
      isCoursesLoading:  isCoursesLoading?? this.isCoursesLoading,
      isCoursesFailed: isCoursesFailed?? this.isCoursesFailed

    );
  }

  // Property to check if the state is initial
  bool get isInitial => this == OnlineExamState.initial();

  @override
  List<Object?> get props => [exam, errorMessage, isLoading , isSuccess, validationMessage, registeredCourses, isCoursesFailed, isCoursesLoading, isCoursesSuccess];
}
