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
    final cachedCourses = await _instance.getCourses() ?? <Map<String, dynamic>>[];

    // Convert the input to a list of course maps
    final newCourses = courses is Map<String, dynamic>
        ? [courses] // Single course as a map
        : courses is List<Map<String, dynamic>>
        ? courses // Already a list of maps
        : <Map<String, dynamic>>[];

    // Add new courses, avoiding duplicates based on a unique identifier (e.g., 'courseCode')
    for (final course in newCourses) {
      final courseCode = course['courseCode']; // Assuming 'courseCode' is a unique identifier
      if (courseCode != null && !cachedCourses.any((c) => c['courseCode'] == courseCode)) {
        cachedCourses.add(course);
      }
    }

    // Save the updated list back to the cache
    await _baseCacheService.save('courses', cachedCourses);
  }

  /// Get all cached courses
  Future<List<Map<String, dynamic>>?> getCourses() async {
    // Read and cast the cached courses to a list of maps
    final courses = await _baseCacheService.read('courses') as List<dynamic>?;
    return courses?.cast<Map<String, dynamic>>();
  }

  /// Clear all cached courses
  Future<void> clearCoursesCache() async {
    await _baseCacheService.delete('courses');
  }

  /// Delete a course by its code
  Future<void> deleteCourseCache(String courseCode) async {
    // Fetch existing cached courses
    final cachedCourses = await _instance.getCourses() ?? <Map<String, dynamic>>[];

    // Remove the specified course if it exists
    cachedCourses.removeWhere((course) => course['courseCode'] == courseCode);

    // Save the updated list back to the cache
    await _baseCacheService.save('courses', cachedCourses);
  }
}
