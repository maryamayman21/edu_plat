part of 'phone_cubit.dart';

abstract class PhoneState {}

class PhoneNumberInitial extends PhoneState {}
class PhoneNumberLoading extends PhoneState {
   PhoneNumberLoading();
}
class PhoneNumberSuccess extends PhoneState {
  final String? phoneNumber;
  PhoneNumberSuccess(this.phoneNumber);

}
class PhoneNumberFailure extends PhoneState {
  final String errorMessage;
  PhoneNumberFailure(this.errorMessage);
}