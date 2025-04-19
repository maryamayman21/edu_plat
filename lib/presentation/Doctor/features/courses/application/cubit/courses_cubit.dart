import 'package:bloc/bloc.dart';
import 'package:edu_platt/core/network_handler/network_handler.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/cashe/services/course_cashe_service.dart';
import '../../../../../Auth/service/token_service.dart';
import '../../data/repositories/course_repository.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final  CourseCacheService courseCacheService ;
  final CourseRepository courseRepository;
  final TokenService tokenService;
  CoursesCubit({
    required this.courseCacheService,
    required this.courseRepository,
    required this.tokenService
}) : super(CoursesInitial());


  Future<void> getCachedCourses()async{

    try {
      print('gettttt');
     final cachedCourses = await courseCacheService.getCourses();
     print(cachedCourses);
     print('got cached courses from cache');
     if (cachedCourses != null && cachedCourses.isNotEmpty) {
       print('Cached courses is not null');
        emit(CoursesSuccess(cachedCourses));
       return;
     } else {
       print('No cache for courses');
        emit(CoursesFailure("No cached courses found."));
     }
   }catch(e){
      print('No cache for courses');
      emit(CoursesFailure("No cached courses found."));
   }
  }


  Future<void> getCourses()async{
    try{
      emit(GetCoursesLoading());
      //try cache
      final cachedCourses = await courseCacheService.getCourses();
      print(cachedCourses);
      print('got cached courses from cache');
      if (cachedCourses != null && cachedCourses.isNotEmpty) {
        print('Cached courses is not null');
        emit(CoursesSuccess(cachedCourses));
        return;
      }
      // emit(CoursesFailure("No cached courses found."));
      //try server
      final token =  await TokenService().getToken();
      print('Got token');
      final response = await courseRepository.getCourses(token!);
      print('Response after get in cubit ${response.data}');
      final List<String>? courses = List<String>.from(response.data);
      print('Courses after get in cubit $courses');
      if(courses != null && courses.isNotEmpty) {
        emit(CoursesSuccess(courses));
      }else{
        emit(CoursesNotFound());
      }


    }catch(error){
      if (!isClosed) emit(CoursesFailure(NetworkHandler.mapErrorToMessage(error)));
    }


  }








  Future<void> deleteCachedCourse(String courseCode , dynamic courses)async{

    try {
      emit(CoursesLoading(courses: courses));
        //delete in server
      final token = await tokenService.getToken();
       await courseRepository.deleteCourse(courseCode, token!);
       print('Deleted course in server successfully');
      //delete in cache
     // if (!isClosed) emit(CourseDeletionSuccess('Course $courseCode has been deleted successfully.'));
       await courseCacheService.deleteCourseCache(courseCode);
       //get updated courses
       final cachedCourses =  await courseCacheService.getCourses();
      if (!isClosed) emit(CourseDeletionSuccess('Course $courseCode has been deleted successfully.', cachedCourses));
      if (cachedCourses != null && cachedCourses.isNotEmpty) {

       // if (!isClosed) emit(CourseDeletionSuccess('Course $courseCode has been deleted successfully.'));
        if (!isClosed)    CoursesSuccess(cachedCourses);

        print('Cached courses is  not null in deletion');
        return;
      } else {
        emit(CoursesNotFound());
      }
    }catch(e){
      if (!isClosed) emit(CoursesDeletionFailure(courses));
    }
  }
  Future<void> deleteAllCachedCourses()async{
    try {

      await courseCacheService.clearCoursesCache();
       print('Cache cleared successfully');

    }catch(e){
      if (!isClosed) {
        print('Couldnt clear cache');
      }
    }
  }




}
