part of 'auth_cubit.dart';
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess(this.message);
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}
class AuthPasswordVisibilityChanged extends AuthState {
  final AuthPasswordVisibility visibility;

  const AuthPasswordVisibilityChanged(this.visibility);

  @override
  List<Object> get props => [visibility];
}
