import '../../../presentation/Doctor/features/courseRegisteration/data/models/course.dart';
import '../base_cashe_service.dart';

class CourseCacheService {
  static final CourseCacheService _instance = CourseCacheService._internal();
  final BaseCacheService _baseCacheService = BaseCacheService();

  CourseCacheService._internal();

  factory CourseCacheService() => _instance;

  /// Save courses (single or multiple) to the cache
  Future<void> saveCourses(dynamic courses) async {
    // Fetch existing cached courses
    final cachedCourses = await _instance.getCourses() ?? <String>[];

    // Convert the input to a list of course codes (strings)
    final newCourses = courses is String
        ? [courses] // Single course as a string
        : courses is List<String>
        ? courses // Already a list of strings
        : [];

    // Add new course codes, avoiding duplicates
    for (final course in newCourses) {
      if (!cachedCourses.contains(course)) {
        cachedCourses.add(course);
      }
    }

    // Save the updated list back to the cache
    await _baseCacheService.save('courses', cachedCourses);
  }

  /// Get all cached courses
  Future<List<String>?> getCourses() async {
    // Read and cast the cached courses to a list of strings
    final courses = await _baseCacheService.read('courses') as List<dynamic>?;
    return courses?.cast<String>();
  }

  /// Clear all cached courses
  Future<void> clearCoursesCache() async {
    await _baseCacheService.delete('courses');
  }

  /// Delete a course by its code
  Future<void> deleteCourseCache(String courseCode) async {
    // Fetch existing cached courses
    final cachedCourses = await _instance.getCourses() ?? <String>[];

    // Remove the specified course if it exists
    cachedCourses.remove(courseCode);

    // Save the updated list back to the cache
    await _baseCacheService.save('courses', cachedCourses);
  }
}
