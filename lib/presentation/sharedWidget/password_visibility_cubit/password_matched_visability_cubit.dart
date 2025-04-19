import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_matched_visability_state.dart';
enum PasswordMatchedVisibility { visible, hidden }
class PasswordMatchedVisabilityCubit extends Cubit<PasswordMatchedVisabilityState> {
  PasswordMatchedVisibility _passwordVisibility =PasswordMatchedVisibility.hidden;
  PasswordMatchedVisabilityCubit() : super(PasswordMatchedVisabilityInitial());

  void togglePasswordVisibility() {
    _passwordVisibility = _passwordVisibility == PasswordMatchedVisibility.hidden
        ?PasswordMatchedVisibility.visible
        : PasswordMatchedVisibility.hidden;
    emit(PasswordMatchedVisibilityChanged(_passwordVisibility));
  }

}
