part of 'profile_photo_cubit.dart';


abstract class ProfilePhotoState {}

class ProfilePhotoInitial extends ProfilePhotoState {}
class ProfilePhotoLoading extends ProfilePhotoState {
  ProfilePhotoLoading();
}
class ProfilePhotoSuccess extends ProfilePhotoState {
  //fetch photo from server
  final   String? photo;
  ProfilePhotoSuccess(this.photo);
}

class ProfilePhotoFailure extends ProfilePhotoState {
  final String errorMessage;

   ProfilePhotoFailure(this.errorMessage);
}
