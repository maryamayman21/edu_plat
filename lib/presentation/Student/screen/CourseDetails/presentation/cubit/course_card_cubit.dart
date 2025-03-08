import 'package:bloc/bloc.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/request/course_card_request.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/course_card_entity.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/repo/course_details_repo.dart';
import 'package:meta/meta.dart';

part 'course_card_state.dart';

class CourseCardCubit extends Cubit<CourseCardState> {
  CourseCardCubit({required this.courseDetailsRepo}) : super(CourseCardInitial());

  final CourseDetailsRepo courseDetailsRepo;

Future<void> fetchCourseCard(String courseCode, String doctorId) async {
  emit(CourseCardLoading());
  var result = await courseDetailsRepo.fetchCourseCard(CourseCardRequest( courseCode: courseCode, doctorId:doctorId ));
  result.fold((failure) {
    emit(CourseCardFailure(errorMessage: failure.message));
  }, (courseCard) {

      emit(CourseCardSuccess(courseCardEntity: courseCard));

  });
}


}
