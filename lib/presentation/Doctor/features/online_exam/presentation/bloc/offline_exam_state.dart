part of 'offline_exam_bloc.dart';


 class OfflineExamState extends Equatable {
  final String errorMessage;
  final OfflineExamModel offlineExamModel;
  final bool isSuccess;
  final bool isLoading;
  final bool isDataLoaded;
  final bool isFailure;

  OfflineExamState( { required this.errorMessage, required this.offlineExamModel, required this.isSuccess, required this.isLoading,required this.isDataLoaded, required this.isFailure});

  factory OfflineExamState.initial() {
    return OfflineExamState(
      isLoading : false,
        isSuccess: false,
        isDataLoaded: false,
        isFailure: false,
        errorMessage:  '',
        offlineExamModel: OfflineExamModel.initial(),
    );
  }



  OfflineExamState copyWith({OfflineExamModel? offlineExamModel, bool? isSuccess, bool? isLoading ,bool? isDataLoaded,  String? errorMessage, bool? isFailure}) {
    return OfflineExamState(
        offlineExamModel: offlineExamModel?? this.offlineExamModel,
          isSuccess:  isSuccess?? this.isSuccess,
         isLoading:  isLoading?? this.isLoading,
      isDataLoaded: isDataLoaded?? this.isDataLoaded,
      isFailure:  isFailure?? this.isFailure,
      errorMessage:  errorMessage?? this.errorMessage
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [offlineExamModel, isLoading, isSuccess, isDataLoaded, isFailure, errorMessage];




}

