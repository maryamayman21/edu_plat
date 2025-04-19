

import 'dart:io';

import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';
import 'package:hive/hive.dart';



// List<CourseDetailsEntity> saveCourseFileHive(CourseDetailsEntity file) {
//    String courseCode = file.courseCode;
//
//   String boxName = getBoxName(file.type!);
//   print('Saved file in box : $boxName');
//   var box = Hive.box<CourseDetailsEntity>(boxName);
//   box.add(file); // Save the single file
//   return box.values.toList(); // Return the updated list
// }
List<CourseDetailsEntity> saveCourseFilesHive(List<CourseDetailsEntity> files) {
  //String boxName = getBoxName(files.first.type!);  // Get the correct box name based on type
  String type  = files.first.type!;
  String courseCode = files.first.courseCode;  // Get the courseCode from the first file
  //print('Saved file in box : $boxName');

  // Open the Hive box which stores a Map of courseCode -> List<CourseDetailsEntity>
  var box = Hive.box<Map<String, List<CourseDetailsEntity>>>('files');

  // Retrieve the current map for the type (which contains courseCode -> List<CourseDetailsEntity>)
  Map<String, List<CourseDetailsEntity>> courseFilesMap = box.get(type) ?? <String, List<CourseDetailsEntity>>{};

  // Check if the courseCode already exists in the map, otherwise create an empty list for the courseCode
  if (!courseFilesMap.containsKey(courseCode)) {
    courseFilesMap[courseCode] = [];
  }

  // Add the new files, checking if the ID already exists for that courseCode
  for (var file in files) {
    if (!courseFilesMap[courseCode]!.any((existingFile) => existingFile.id == file.id)) {
      courseFilesMap[courseCode]!.add(file);  // Add the file only if it doesn't already exist
    }
  }

  // Save the updated map back to the Hive box
  box.put(type, courseFilesMap);

  // Return the list of files for the given course code
  return courseFilesMap[courseCode]!;
}

List<CourseDetailsEntity> getFilesByTypeHive(String type, String courseCode) {
  //String boxName = getBoxName('files');
  var box = Hive.box<Map<String, List<CourseDetailsEntity>>>('files');

  // Retrieve the map of files for the given type (which is a map with course codes as keys)
  Map<String, List<CourseDetailsEntity>> courseFilesMap = box.get(type) ?? <String, List<CourseDetailsEntity>>{};

  // Retrieve the list of files for the specific courseCode, or an empty list if the courseCode doesn't exist
  List<CourseDetailsEntity> courseFiles = courseFilesMap[courseCode] ?? [];

  return courseFiles;
}



// List<CourseDetailsEntity> getFilesByTypeHive(String type) {
//   String boxName = getBoxName(type);
//   var box = Hive.box<CourseDetailsEntity>(boxName);
//   return box.values.toList();
// }

// List<CourseDetailsEntity> deleteFileByIndex(int index , String type) {
//   //String boxName = getBoxName();
//   var box = Hive.box<CourseDetailsEntity>('files');
//   final courseEntity = box.getAt(index);
//   deleteCachedFile(courseEntity!.path);
//   box.deleteAt(index);
//    return box.values.toList();
// }



List<CourseDetailsEntity> deleteFileByIndex(int index, String type, String courseCode) {
  // Get the correct box based on the file type
  var box = Hive.box<Map<String, List<CourseDetailsEntity>>>('files');

  // Retrieve the current map of course files for the given type
  Map<String, List<CourseDetailsEntity>> courseFilesMap = box.get(type) ?? <String, List<CourseDetailsEntity>>{};

  // Check if the courseCode exists in the map
  if (courseFilesMap.containsKey(courseCode)) {
    var courseFilesList = courseFilesMap[courseCode]!;

    // Ensure the index is valid before attempting to delete
    if (index >= 0 && index < courseFilesList.length) {
      // Remove the file at the specified index
      deleteCachedFile(courseFilesList[index].path);

      // Delete the file from the list
      courseFilesList.removeAt(index);

      // Save the updated map back to the Hive box
      box.put(type, courseFilesMap);
    } else {
      print('Invalid index: $index');
    }
  } else {
    print('Course code $courseCode not found in the box.');
  }

  // Return the updated list of files for the given courseCode
  return courseFilesMap[courseCode] ?? [];
}





List<CourseDetailsEntity> updateFile(int index, CourseDetailsEntity file) {
  //String boxName = getBoxName(file.type!);  // Get the correct box name based on type
  var box = Hive.box<Map<String, List<CourseDetailsEntity>>>('files');
   String type = file.type!;
  String courseCode = file.courseCode;  // Get the courseCode from the file object
  print('Index in hive: $index');

  // Retrieve the current map of files for the type (which contains courseCode -> List<CourseDetailsEntity>)
  Map<String, List<CourseDetailsEntity>> courseFilesMap = box.get(type) ?? <String, List<CourseDetailsEntity>>{};

  // Check if the list for the courseCode exists and update it
  if (courseFilesMap.containsKey(courseCode)) {
    var courseFilesList = courseFilesMap[courseCode]!;

    // // Remove the old file at the given index
    // deleteCachedFile(courseFilesList[index].path);

    // Update the file at the specified index
    courseFilesList[index] = file;

    // Save the updated map back to Hive
    box.put(type, courseFilesMap);

    print('Index in hive after put: $index');
  }

  // Return the updated list of files for the given courseCode
  return courseFilesMap[courseCode]!;
}



// List<CourseDetailsEntity> updateFile(int index , CourseDetailsEntity file) {
//   String boxName = getBoxName(file.type!);
//   var box = Hive.box<CourseDetailsEntity>(boxName);
//   final courseEntity = box.getAt(index);
//   print(' index in hive $index');
//   deleteCachedFile(courseEntity!.path);
//   box.putAt(index, file);
//   print(' index in hive after put$index');
//   return box.values.toList();
// }



// String getBoxName(String type){
//   switch(type){
//     case 'Material' :
//          return materialFilesdBox;
//     case 'Labs' :
//       return labFilesBox;
//     case 'Exams' :
//       return examFilesBox;
//     case 'Videos' :
//       return videosBox;
//     default:
//       return examFilesBox;
//   }
// }
Future<void> deleteCachedFile(String? filePath) async {
  try {
    final file = File(filePath!);

    // Check if the file exists before attempting to delete it.
    if (await file.exists()) {
      await file.delete();
      print('File deleted successfully: $filePath');
    } else {
      print('File not found: $filePath');
    }
  } catch (e) {
    print('Error deleting file: $e');
  }
}
int? getIdByIndex(int index, String type, String courseCode) {
  // Get the correct Hive box
  var box = Hive.box<Map<String, List<CourseDetailsEntity>>>('files');

  // Retrieve the current map of course files for the given type
  Map<String, List<CourseDetailsEntity>> courseFilesMap =
      box.get(type) ?? <String, List<CourseDetailsEntity>>{};

  // Check if the courseCode exists in the map
  if (courseFilesMap.containsKey(courseCode)) {
    var courseFilesList = courseFilesMap[courseCode]!;

    // Ensure the index is valid before retrieving the id
    if (index >= 0 && index < courseFilesList.length) {
      return courseFilesList[index].id; // Return the id of the course entity
    } else {
      print('Invalid index: $index');
    }
  } else {
    print('Course code $courseCode not found in the box.');
  }

  return null; // Return null if id is not found
}

String? getFilePath(int index, String type, String courseCode) {
  // Get the correct Hive box
  var box = Hive.box<Map<String, List<CourseDetailsEntity>>>('files');

  // Retrieve the current map of course files for the given type
  Map<String, List<CourseDetailsEntity>> courseFilesMap =
      box.get(type) ?? <String, List<CourseDetailsEntity>>{};

  // Check if the courseCode exists in the map
  if (courseFilesMap.containsKey(courseCode)) {
    var courseFilesList = courseFilesMap[courseCode]!;

    // Ensure the index is valid before retrieving the id
    if (index >= 0 && index < courseFilesList.length) {
      return courseFilesList[index].path; // Return the id of the course entity
    } else {
      print('Invalid index: $index');
    }
  } else {
    print('Course code $courseCode not found in the box.');
  }

  return null; // Return null if id is not found
}

String? getFileName(int index, String type, String courseCode) {
  // Get the correct Hive box
  var box = Hive.box<Map<String, List<CourseDetailsEntity>>>('files');

  // Retrieve the current map of course files for the given type
  Map<String, List<CourseDetailsEntity>> courseFilesMap =
      box.get(type) ?? <String, List<CourseDetailsEntity>>{};

  // Check if the courseCode exists in the map
  if (courseFilesMap.containsKey(courseCode)) {
    var courseFilesList = courseFilesMap[courseCode]!;

    // Ensure the index is valid before retrieving the id
    if (index >= 0 && index < courseFilesList.length) {
      return courseFilesList[index].name; // Return the id of the course entity
    } else {
      print('Invalid index: $index');
    }
  } else {
    print('Course code $courseCode not found in the box.');
  }

  return null; // Return null if id is not found
}
