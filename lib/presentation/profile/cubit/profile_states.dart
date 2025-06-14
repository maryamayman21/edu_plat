part of 'profile_cubit.dart';


abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class LogOutSuccess extends ProfileState {}

class ProfileLoading extends ProfileState {

//  final UserModel userModel;
  ProfileLoading();

}

class PhotoSelected extends ProfileState {
  final UserModel userModel;

  PhotoSelected(this.userModel);

}

class PhoneNumberUpdated extends ProfileState {
  final UserModel userModel;


  PhoneNumberUpdated(this.userModel);
}


class ProfileLoaded extends ProfileState {
  final UserModel userModel;

  ProfileLoaded(this.userModel);
}
class ProfileError extends ProfileState {
  final String errorMessage;

  ProfileError(this.errorMessage);
}
class LogoutError extends ProfileState {
  final String errorMessage;

  LogoutError(this.errorMessage);
}
