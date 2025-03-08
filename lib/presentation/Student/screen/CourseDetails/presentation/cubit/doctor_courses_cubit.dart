import 'package:bloc/bloc.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/request/doctor_courses_request.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/doctor_courses_entity.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/repo/course_details_repo.dart';
import 'package:meta/meta.dart';

part 'doctor_courses_state.dart';

class DoctorCoursesCubit extends Cubit<DoctorCoursesState> {
  DoctorCoursesCubit({required this.courseDetailsRepo}) : super(DoctorCoursesInitial());
  final CourseDetailsRepo courseDetailsRepo;

Future<void> fetchDoctorCourses(String courseCode) async {
  emit(DoctorCoursesLoading());
  var result = await courseDetailsRepo.fetchDoctorCourses(DoctorCoursesRequest(courseCode: courseCode));
  result.fold((failure) {
    emit(DoctorCoursesFailure(errorMessage: failure.message));
  }, (doctorCourses) {
      emit(DoctorCoursesSuccess(doctorCoursesEntity: doctorCourses));
  });
 }
}
