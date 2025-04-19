import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_visiability_state.dart';
enum PasswordVisibility { visible, hidden }
class PasswordVisiabilityCubit extends Cubit<PasswordVisiabilityState> {
  PasswordVisibility _passwordVisibility = PasswordVisibility.hidden;
  PasswordVisiabilityCubit() : super(PasswordVisiabilityInitial());


  void togglePasswordVisibility() {
    _passwordVisibility = _passwordVisibility == PasswordVisibility.hidden
        ? PasswordVisibility.visible
        : PasswordVisibility.hidden;
    emit(PasswordVisibilityChanged(_passwordVisibility));
  }

}
