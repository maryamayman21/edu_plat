import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/network_handler/network_handler.dart';
import 'package:edu_platt/presentation/Doctor/features/courseRegisteration/data/models/course.dart';
import 'package:meta/meta.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';

import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/data/reposatories/repo.dart';
part 'studentcourse_registeration_state.dart';

class StudentCourseRegisterationCubit extends Cubit<StudentCourseRegisterationState> {
  final TokenService tokenService;
  final StudentCourseRegistrationRepository studentcourseRegistrationRepository;
  final CourseCacheService courseCacheService;
  StudentCourseRegisterationCubit(
      {required this.studentcourseRegistrationRepository,
        required this.tokenService,
        required this.courseCacheService})
      : super(CourseRegisterationInitial());

  Future<void> fetchRegistrationCourses(int semesterID) async {
    emit(CourseRegisterationLoading());
    try {
      final token = await tokenService.getToken();
      print("Done");
      print('Token $token');
      print('Semester id $semesterID');
      final response = await studentcourseRegistrationRepository
          .fetchRegistrationCourses(semesterID, token!);
      print("Done before getting semseter ");
      final semester = Semester.fromJson(response.data);
      print("Done after getting semseter ");
      final level1Courses =
          semester.levels.firstWhere((level) => level.levelId == 1).courses;
      final level2Courses =
          semester.levels.firstWhere((level) => level.levelId == 2).courses;
      final level3Courses =
          semester.levels.firstWhere((level) => level.levelId == 3).courses;
      final level4Courses =
          semester.levels.firstWhere((level) => level.levelId == 4).courses;
      // print(level1Courses);
      // print(level2Courses);
      // print(level3Courses);
      // print(level4Courses);
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
      //cache courses
      final token = await tokenService.getToken();
      final response =
      await studentcourseRegistrationRepository.registerCourses(courses, token!);

      final responseData = response.data;
      if (responseData['success'] == true) {
    //    await courseCacheService.saveCourses(courses);

        final message = responseData['message'] ?? 'Registration successful.';
        emit(CoursesRegistered(message));
      } else {
        emit(CourseRegisterationFailure('Registration failed'));
      }
    } catch (error) {
      if (!isClosed) {
        if (error is DioError && error.response != null) {
          // Handle specific API errors
          final errorMessage =
              error.response?.data['message'] ?? 'An unexpected error occurred';
          emit(CourseRegisterationFailure(errorMessage));
        } else {
          emit(CourseRegisterationFailure(
              NetworkHandler.mapErrorToMessage(error)));
        }
      }
    }
  }
}
