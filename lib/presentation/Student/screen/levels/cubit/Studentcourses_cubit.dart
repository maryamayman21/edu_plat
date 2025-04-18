import 'package:bloc/bloc.dart';
import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/network_handler/network_handler.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Student/screen/levels/data/repositories/course_repository.dart';
import 'package:meta/meta.dart';



part 'Studentcourses_state.dart';

class StudentCoursesCubit extends Cubit<StudentCoursesState> {
  final  CourseCacheService courseCacheService ;
  final StudentCourseRepository courseRepository;
  final TokenService tokenService;
  StudentCoursesCubit({
    required this.courseCacheService,
    required this.courseRepository,
    required this.tokenService
}) : super(CoursesInitial() as StudentCoursesState);


  Future<void> getCachedCourses()async{

    try {
     final cachedCourses = await courseCacheService.getCourses();
     print(cachedCourses);
     print('got cached courses from cache');
     if (cachedCourses != null && cachedCourses.isNotEmpty) {
       print('Cached courses is not null');
        emit(CoursesSuccess(cachedCourses) as StudentCoursesState);
       return;
     } else {
       print('No cache for courses');
        emit(CoursesFailure("No cached courses found.") as StudentCoursesState);
     }
   }catch(e){
      print('No cache for courses');
      emit(CoursesFailure("No cached courses found.") as StudentCoursesState);
   }
  }


  Future<void> getCourses()async{
    try{
      emit(GetCoursesLoading() as StudentCoursesState);
      //try cache
      final cachedCourses = await courseCacheService.getCourses();
     // final List<Map<String, dynamic>>? cachedCourses= [{'courseCode' : 'COMP104' , 'hasLab' : true}, {'courseCode' : 'COMP203' , 'hasLab' : false}];
       print(  'Cached courses : $cachedCourses');
       print('got cached courses from cache');
       if (cachedCourses != null && cachedCourses.isNotEmpty) {
        print('Cached courses is not null');
        emit(CoursesSuccess(cachedCourses) as StudentCoursesState);
        return;
      }
      // emit(CoursesFailure("No cached courses found."));
      //try server
      final token =  await TokenService().getToken();
      print('Got token');
      final response = await courseRepository.getCourses(token!);
      print('Response after get in cubit ${response.data}');
      ///TODO:: CONVERT TO LIST OF MAP
      final List<Map<String, dynamic>>? courses = List<Map<String, dynamic>>.from(response.data);
     // final List<Map<String, dynamic>>?  courses = [{'courseCode' : 'COMP104' , 'hasLab' : true}, {'courseCode' : 'COMP203' , 'hasLab' : false}];
      print('Courses after get in cubit $courses');
      if(courses != null && courses.isNotEmpty) {
        emit(CoursesSuccess(courses) as StudentCoursesState);
      }else{
        emit(CoursesNotFound() as StudentCoursesState);
      }


     }catch(error){
      if (!isClosed) emit(CoursesFailure(NetworkHandler.mapErrorToMessage(error)) as StudentCoursesState);
    }

  }








  Future<void> deleteCachedCourse(String courseCode , dynamic courses)async{

    try {
      emit(CoursesLoading(courses: courses) as StudentCoursesState);
        //delete in server
      final token = await tokenService.getToken();
       await courseRepository.deleteCourse(courseCode, token!);
       print('Deleted course in server successfully');
      //delete in cache
     // if (!isClosed) emit(CourseDeletionSuccess('Course $courseCode has been deleted successfully.'));
       await courseCacheService.deleteCourseCache(courseCode);
       //get updated courses
       final cachedCourses =  await courseCacheService.getCourses();
      if (!isClosed) emit(CourseDeletionSuccess('Course $courseCode has been deleted successfully.', cachedCourses) as StudentCoursesState);
      if (cachedCourses != null && cachedCourses.isNotEmpty) {

       // if (!isClosed) emit(CourseDeletionSuccess('Course $courseCode has been deleted successfully.'));
        if (!isClosed)    CoursesSuccess(cachedCourses);

        print('Cached courses is  not null in deletion');
        return;
      } else {
        emit(CoursesNotFound() as StudentCoursesState);
      }
    }catch(e){
      if (!isClosed) emit(CoursesDeletionFailure(courses) as StudentCoursesState);
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
