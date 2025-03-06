part of 'gpa_cubit.dart';


@immutable
sealed class GpaState {}

class GpaInitial extends GpaState {}

class GpaLoading extends GpaState {}

class GpaLoaded extends GpaState {
  final GpaModel gpa;
  GpaLoaded(this.gpa);
}

class GpaError extends GpaState {
  final String message;
  GpaError(this.message);
}


