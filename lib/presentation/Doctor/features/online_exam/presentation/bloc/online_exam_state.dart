

part of 'online_exam_bloc.dart';

class OnlineExamState extends Equatable {
  final OnlineExamModel exam;
  final String errorMessage;
  final bool isLoading;
  final bool isSuccess;
  final bool isDataLoaded;
  final bool isFailure;
  final String validationMessage;

  const OnlineExamState(  {required this.exam, required this.errorMessage,required this.isLoading,  required this.isSuccess, required this.isDataLoaded, required this.isFailure, required this.validationMessage });

  factory OnlineExamState.initial() {
    return OnlineExamState(
      exam: OnlineExamModel.initial(),
      errorMessage : '',
       validationMessage: '',
       isLoading: false,
        isSuccess: false,
         isDataLoaded: false,
         isFailure: false
    );
  }

  OnlineExamState copyWith({OnlineExamModel? exam, String? errorMessage,String? validationMessage , bool? isLoading , bool? isSuccess , bool? isDataLoaded ,bool? isFailure}) {
    return OnlineExamState(
      exam: exam ?? this.exam,
      validationMessage:  validationMessage ?? this.validationMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading:  isLoading ?? this.isLoading,
      isSuccess:  isSuccess ?? this.isSuccess,
      isFailure: isFailure?? this.isFailure,
      isDataLoaded: isDataLoaded?? this.isDataLoaded

    );
  }

  // Property to check if the state is initial
  bool get isInitial => this == OnlineExamState.initial();

  @override
  List<Object?> get props => [exam, errorMessage, isLoading , isSuccess, validationMessage];
}
