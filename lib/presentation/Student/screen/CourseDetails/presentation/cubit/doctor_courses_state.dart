part of 'doctor_courses_cubit.dart';

@immutable
sealed class DoctorCoursesState {}

final class DoctorCoursesInitial extends DoctorCoursesState {}
final class DoctorCoursesSuccess extends DoctorCoursesState {
final List<DoctorCoursesEntity> doctorCoursesEntity;
DoctorCoursesSuccess({required this.doctorCoursesEntity});
}
final class DoctorCoursesLoading extends DoctorCoursesState {}
final class DoctorCoursesFailure extends DoctorCoursesState {
  final String errorMessage;

  DoctorCoursesFailure({required this.errorMessage});
}
