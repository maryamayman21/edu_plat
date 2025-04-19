


import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
enum StatusDialog{SUCCESS
  , LOADING , FAILURE, CONFIRM}
class DialogCubit extends Cubit<StatusDialog?> {
  DialogCubit() : super(null);
  bool? action;
  void setStatus(String status) {
     switch(status){
       case 'Success' :
         emit(StatusDialog.SUCCESS);
         break;
       case 'Failure' :
         emit(StatusDialog.FAILURE);
         break;
       case 'Loading' :
         emit(StatusDialog.LOADING);
         break;
       case 'Confirm' :
         emit(StatusDialog.CONFIRM);
         break;
     }
  }

  // void  confirmAction(bool userAction) {
  //   print('User action in conFirm Action $userAction');
  //    action =  userAction;
  //    emit(null); // Emit a new state
  // }

}
