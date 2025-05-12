import 'package:bloc/bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/courses/data/network/requests/delete_course_request.dart';
import 'package:edu_platt/presentation/courses/data/repo/courses_repoImp.dart';
import 'package:edu_platt/presentation/courses/domain/entity/course_entity.dart';
import 'package:meta/meta.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit({
    required this.dialogCubit,
    required this.coursesRepoImpl
}) : super(CoursesInitial());
  final DialogCubit dialogCubit;
  final CoursesRepoImpl coursesRepoImpl;

  Future<void> fetchCourses()async{
    emit(CoursesLoading());
    final result = await coursesRepoImpl.fetchCourses();
    result.fold((failure) {
        emit(CoursesFailure(errorMessage: failure.message));

    }, (courses) {
      if (courses.isEmpty) {
        emit(CoursesInitial());
      }
      else {
        emit(CoursesSuccess(courses: courses));
      }
    });
  }

  Future<void> deleteCourse(String courseCode)async{
    dialogCubit.setStatus('Loading');
    final deleteResult = await coursesRepoImpl.deleteCourse(DeleteCourseRequest(courseCode: courseCode));
    if (deleteResult.isLeft()) {
      // Emit an error state if the delete operation fails
      dialogCubit.setStatus('Failure', message:'Failed to delete course, try again' );
      return;
    }

    final fetchResult = await coursesRepoImpl.fetchCourses();
    fetchResult.fold(
          (failure) {
        dialogCubit.setStatus('Failure', message: failure.message);
      },
          (courses) {
        dialogCubit.setStatus( 'Success', message: '$courseCode has been deleted successfully');
        if (courses.isEmpty) {
          emit(CoursesInitial());
        }
        else {
          emit(CoursesSuccess(courses: courses));
        }
      },
    );
  }
}





