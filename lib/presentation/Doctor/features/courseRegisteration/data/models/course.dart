class Course {
  final String courseCode;
  final String courseDescription;

  Course({required this.courseCode, required this.courseDescription});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseCode: json['courseCode'],
      courseDescription: json['courseDescription'],
    );
  }
}

class Level {
  final int levelId;
  final List<Course> courses;

  Level({required this.levelId, required this.courses});

  factory Level.fromJson(Map<String, dynamic> json) {
    List<Course> courses = [];
    // Extract courses for the respective level
    json.forEach((key, value) {
      if (key.contains('Courses') && value is List) {
        courses = value.map((course) => Course.fromJson(course)).toList();
      }
    });
    return Level(levelId: json['levelId'], courses: courses);
  }
}

class Semester {
  final int semesterId;
  final List<Level> levels;

  Semester({required this.semesterId, required this.levels});

  factory Semester.fromJson(Map<String, dynamic> json) {
    List<Level> levels = (json['semesterLevels'] as List)
        .map((levelJson) => Level.fromJson(levelJson))
        .toList();

    return Semester(
      semesterId: json['smesterId'],
      levels: levels,
    );
  }
}
