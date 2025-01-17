part of 'forget_pass_cubit.dart';

@immutable
sealed class ForgetPassState extends Equatable {

  @override
  List<Object> get props => [];

}

final class ForgetPassInitial extends ForgetPassState {}
final class ForgetPassLoading extends ForgetPassState {}
class ForgetPassSuccess extends ForgetPassState {
  final String message;
  ForgetPassSuccess(this.message);
}

class ForgetPassFailure extends ForgetPassState {
  final String error;

   ForgetPassFailure(this.error);

  @override
  List<Object> get props => [error];
}

