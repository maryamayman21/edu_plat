part of 'password_matched_visability_cubit.dart';

@immutable
sealed class PasswordMatchedVisabilityState {}

final class PasswordMatchedVisabilityInitial extends PasswordMatchedVisabilityState {}
class PasswordMatchedVisibilityChanged extends PasswordMatchedVisabilityState  {
  final PasswordMatchedVisibility visibility;

  PasswordMatchedVisibilityChanged(this.visibility);

}
