part of 'password_visiability_cubit.dart';

@immutable
sealed class PasswordVisiabilityState {}

final class PasswordVisiabilityInitial extends PasswordVisiabilityState {}
class PasswordVisibilityChanged extends PasswordVisiabilityState  {
  final PasswordVisibility visibility;

   PasswordVisibilityChanged(this.visibility);

}
