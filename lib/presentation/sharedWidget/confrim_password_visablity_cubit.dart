import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'confrim_password_visablity_state.dart';
enum ConfirmPasswordVisibility { visible, hidden }
class ConfrimPasswordVisablityCubit extends Cubit<ConfrimPasswordVisablityState> {
  ConfirmPasswordVisibility _passwordVisibility = ConfirmPasswordVisibility.hidden;
  ConfrimPasswordVisablityCubit() : super(ConfrimPasswordVisablityInitial());

  void togglePasswordVisibility() {
    _passwordVisibility = _passwordVisibility == ConfirmPasswordVisibility.hidden
        ?ConfirmPasswordVisibility.visible
        : ConfirmPasswordVisibility.hidden;
    emit(ConfirmPasswordVisibilityChanged(_passwordVisibility));
  }


}
