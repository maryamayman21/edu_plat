part of 'confrim_password_visablity_cubit.dart';

@immutable
sealed class ConfrimPasswordVisablityState {}

final class ConfrimPasswordVisablityInitial extends ConfrimPasswordVisablityState {}
class ConfirmPasswordVisibilityChanged extends ConfrimPasswordVisablityState   {
  final ConfirmPasswordVisibility visibility;

  ConfirmPasswordVisibilityChanged(this.visibility);

}