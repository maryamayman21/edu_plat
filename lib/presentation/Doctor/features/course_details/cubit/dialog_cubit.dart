
import 'package:flutter_bloc/flutter_bloc.dart';
enum StatusDialog{SUCCESS
  , LOADING , FAILURE, CONFIRM}
class DialogState {
  final StatusDialog status;
  final String? message;

  DialogState({required this.status, this.message});
}

class DialogCubit extends Cubit<DialogState?> {
  DialogCubit() : super(null);

  bool? action;

  void setStatus(String status, {String? message}) {
    switch (status) {
      case 'Success':
        emit(DialogState(status: StatusDialog.SUCCESS, message: message));
        break;
      case 'Failure':
        emit(DialogState(status: StatusDialog.FAILURE, message: message));
        break;
      case 'Loading':
        emit(DialogState(status: StatusDialog.LOADING, message: message));
        break;
      case 'Confirm':
        emit(DialogState(status: StatusDialog.CONFIRM, message: message));
        break;
    }
  }
}

