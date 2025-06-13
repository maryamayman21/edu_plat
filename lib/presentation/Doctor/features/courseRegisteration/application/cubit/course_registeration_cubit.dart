import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edu_platt/presentation/Doctor/features/courseRegisteration/data/models/course.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/cashe/services/course_cashe_service.dart';
import '../../../../../../core/network_handler/network_handler.dart';
import '../../../../../Auth/service/token_service.dart';
import '../../data/repositories/repository.dart';

part 'course_registeration_state.dart';

class CourseRegisterationCubit extends Cubit<CourseRegisterationState> {
  final TokenService tokenService;
  final CourseRegistrationRepository courseRegistrationRepository;
  final CourseCacheService courseCacheService;
  final DialogCubit dialogCubit;
  CourseRegisterationCubit(
      {required this.courseRegistrationRepository,
      required this.tokenService,
      required this.courseCacheService,
      required this.dialogCubit
      })
      : super(CourseRegisterationInitial());

  Future<void> fetchRegistrationCourses(int semesterID) async {
    emit(CourseRegisterationLoading());
    try {
      final token = await tokenService.getToken();
      final response = await courseRegistrationRepository
          .fetchRegistrationCourses(semesterID, token!);
      final semester = Semester.fromJson(response.data);
      final level1Courses =
          semester.levels.firstWhere((level) => level.levelId == 1).courses;
      final level2Courses =
          semester.levels.firstWhere((level) => level.levelId == 2).courses;
      final level3Courses =
          semester.levels.firstWhere((level) => level.levelId == 3).courses;
      final level4Courses =
          semester.levels.firstWhere((level) => level.levelId == 4).courses;
      emit(CourseRegisterationSuccess(
          level1Courses, level2Courses, level3Courses, level4Courses));
    } catch (error) {
      if (!isClosed) {
        if (error is DioError && error.response != null) {
          // Handle specific API errors
          final errorMessage =
              error.response?.data ?? 'An unexpected error occurred';

          emit(CourseRegisterationFailure(errorMessage.toString()));
        } else {
          emit(CourseRegisterationFailure(
              NetworkHandler.mapErrorToMessage(error)));
        }
      }
    }
  }

  Future<void> registerCourses(List<String> courses) async {
    try {
      dialogCubit.setStatus('Loading');
      //List<String> courseCodes = courses.map((course) => course['courseCode'] as String).toList();

      final token = await tokenService.getToken();
   //   print("Doctor registeration in cubit");
      final response =
          await courseRegistrationRepository.registerCourses(courses, token!);

      final responseData = response.data;
      if (responseData['success'] == true) {

        // await courseCacheService.saveCourses(courses);
        //print('Registered courses in cache : $courses');
        final message = responseData['message'] ?? 'Registration successful.';
        dialogCubit.setStatus( 'Success', message:message, );
        emit(CoursesRegistered(message));
      } else if (responseData['success'] == false){
        final message = responseData['message'] ?? 'Registration failed.';
        print('done4');
        dialogCubit.setStatus('Failure', message:message );
       // emit(CourseRegisterationFailure(message));
      }else{
        print('done3');
        dialogCubit.setStatus('Failure', message:'No internet connection');
      }
    } catch (error) {
      if (!isClosed) {
        if (error is DioError && error.response != null) {
          // Handle specific API errors
          final errorMessage =
              error.response?.data['message'] ?? 'An unexpected error occurred';
        //  emit(CourseRegisterationFailure(errorMessage));
          print('done2');
          dialogCubit.setStatus('Failure', message:errorMessage);
        } else {
          print('done1');
          dialogCubit.setStatus('Failure', message:NetworkHandler.mapErrorToMessage(error));
          // emit(CourseRegisterationFailure(
          //     NetworkHandler.mapErrorToMessage(error)));
        }
      }
    }
  }
}
