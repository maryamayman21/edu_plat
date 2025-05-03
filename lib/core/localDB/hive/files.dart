
import 'dart:io';
import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';
import 'package:hive/hive.dart';
  class HiveService {
  // Add a file to the appropriate box
    static Future<List<CourseDetailsEntity>> addFile({
      required List<CourseDetailsEntity> fileDataList,
    }) async {
      if (fileDataList.isEmpty) {
        return []; // Return an empty list if no data is provided
      }

      // Assuming all entities in the list have the same type and courseCode
      final boxName = fileDataList.first.type;
      final key = fileDataList.first.courseCode;
      final box = Hive.box<List<Map<String, List<CourseDetailsEntity>>>>(boxName!);

      print('Box length before adding files: ${box.values.length}');

      // Retrieve existing data from the box
      final List<Map<String, List<CourseDetailsEntity>>> existingData = await getBoxData(box);

      // If the box is empty, initialize it with a new list
      if (existingData.isEmpty) {
        await box.put('files', [
          {key: fileDataList} // Add the entire list of entities
        ]);
      } else {
        // Check if the key already exists
        bool keyExists = false;
        for (var map in existingData) {
          if (map.containsKey(key)) {
            // Append the new entities to the existing list for the key
            map[key]!.addAll(fileDataList);
            keyExists = true;
            break;
          }
        }

        // If the key doesn't exist, add a new map with the key and fileDataList
        if (!keyExists) {
          existingData.add({key: fileDataList});
        }

        // Update the box with the modified data
        await box.put('files', existingData);
      }

      // Fetch the updated list of CourseDetailsEntity for the given key
      final updatedData = await getBoxData(box);
      final List<CourseDetailsEntity> result = [];
      for (var map in updatedData) {
        if (map.containsKey(key)) {
          result.addAll(map[key]!);
          break;
        }
      }

      print('Box length after adding files: ${box.values.length}');
      return result;
    }
  // Get all files from a box
  static List<CourseDetailsEntity> getFiles({
    required String boxName,
    required String key,
  })
  {
    final box = Hive.box<List<Map<String, List<CourseDetailsEntity>>>>(boxName);
    final List<Map<String, List<CourseDetailsEntity>>>? allFiles = box.get('files', defaultValue: []);

    // Find the map that contains the specified key
    for (var map in allFiles!) {
      if (map.containsKey(key)) {
        return map[key]!; // Return the list of CourseDetailsEntity for the given key
      }
    }

    return [];
  }

    static Future<List<CourseDetailsEntity>> updateFile({
      required int index,
      required CourseDetailsEntity updatedFile,
    }) async {
      // Get boxName and key from the updatedFile
      final boxName = updatedFile.type;
      final key = updatedFile.courseCode;

      final box = Hive.box<List<Map<String, List<CourseDetailsEntity>>>>(boxName!);
      final List<Map<String, List<CourseDetailsEntity>>> existingData = await getBoxData(box);

      for (var map in existingData) {
        if (map.containsKey(key)) {
          // Get the list of CourseDetailsEntity for the given key
          final List<CourseDetailsEntity> fileList = map[key]!;

          // Check if the index is valid
          if (index >= 0 && index < fileList.length) {
            // Update the file at the specified index
            fileList[index] = updatedFile;

            // Update the map with the modified list
            map[key] = fileList;

            // Update the box
            await box.put('files', existingData);

            // Return the updated list
            return fileList;
          } else {
            throw Exception('Invalid index: $index');
          }
        }
      }

      throw Exception('Key not found or box is empty');
    }
  // Delete a file from a box
    static Future<List<CourseDetailsEntity>> deleteFile({
      required int index,
      required String type,
      required String courseCode,
    }) async {
      final box = Hive.box<List<Map<String, List<CourseDetailsEntity>>>>(type);
      final List<Map<String, List<CourseDetailsEntity>>> existingData = await getBoxData(box);

      for (var map in existingData) {
        if (map.containsKey(courseCode)) {
          // Get the list of CourseDetailsEntity for the given key
          final List<CourseDetailsEntity> fileList = map[courseCode]!;

          // Check if the index is valid
          if (index >= 0 && index < fileList.length) {
            // Remove the file at the specified index
            fileList.removeAt(index);

            // Update the map with the modified list
            map[courseCode] = fileList;

            // Update the box
            await box.put('files', existingData);

            // Return the updated list
            return fileList;
          } else {
            throw Exception('Invalid index: $index');
          }
        }
      }

      throw Exception('Key not found or box is empty');
    }

    static Future<int?> getFileId({
      required int index,
      required String type,
      required String courseCode,
    }) async {
      final box = Hive.box<List<Map<String, List<CourseDetailsEntity>>>>(type);
      final List<Map<String, List<CourseDetailsEntity>>> existingData = await getBoxData(box);

      for (var map in existingData) {
        if (map.containsKey(courseCode)) {
          // Get the list of CourseDetailsEntity for the given key
          final List<CourseDetailsEntity> fileList = map[courseCode]!;

          // Check if the index is valid
          if (index >= 0 && index < fileList.length) {
            // Return the id of the file at the specified index
            return fileList[index].id;
          } else {
            throw Exception('Invalid index: $index');
          }
        }
      }

      throw Exception('Key not found or box is empty');
    }

    static Future<String> getFilePath({
      required int index,
      required String type,
      required String courseCode,
    }) async {
      final box = Hive.box<List<Map<String, List<CourseDetailsEntity>>>>(type);
      final List<Map<String, List<CourseDetailsEntity>>> existingData = await getBoxData(box);

      for (var map in existingData) {
        if (map.containsKey(courseCode)) {
          // Get the list of CourseDetailsEntity for the given key
          final List<CourseDetailsEntity> fileList = map[courseCode]!;

          // Check if the index is valid
          if (index >= 0 && index < fileList.length) {
            // Return the filePath of the file at the specified index
            return fileList[index].path!;
          } else {
            throw Exception('Invalid index: $index');
          }
        }
      }

      throw Exception('Key not found or box is empty');
    }

    static Future<String> getFileName({
      required int index,
      required String type,
      required String courseCode,
    }) async {
      final box = Hive.box<List<Map<String, List<CourseDetailsEntity>>>>(type);
      final List<Map<String, List<CourseDetailsEntity>>> existingData = await getBoxData(box);

      for (var map in existingData) {
        if (map.containsKey(courseCode)) {
          // Get the list of CourseDetailsEntity for the given key
          final List<CourseDetailsEntity> fileList = map[courseCode]!;

          // Check if the index is valid
          if (index >= 0 && index < fileList.length) {
            // Return the fileName of the file at the specified index
            return fileList[index].name;
          } else {
            throw Exception('Invalid index: $index');
          }
        }
      }

      throw Exception('Key not found or box is empty');
    }

    static Future<List<Map<String, List<CourseDetailsEntity>>>> getBoxData(Box box) async {
      final dynamic rawData = box.get('files');
      print('Raw Data: $rawData'); // Debug log to inspect the raw data

      if (rawData != null) {
        if (rawData is List) {
          print('Raw Data is a List');
          final List<Map<String, List<CourseDetailsEntity>>> existingData = [];

          for (var item in rawData) {
            if (item is Map<String, dynamic>) {
              print('Item is a Map: $item');
              final Map<String, List<CourseDetailsEntity>> convertedMap = {};

              item.forEach((key, value) {
                if (value is List) {
                  print('Value is a List: $value');
                  final List<CourseDetailsEntity> courseDetailsList = value
                      .whereType<CourseDetailsEntity>() // Filter only CourseDetailsEntity objects
                      .toList();

                  convertedMap[key] = courseDetailsList;
                } else {
                  throw Exception('Invalid data type: expected List<CourseDetailsEntity>');
                }
              });

              existingData.add(convertedMap);
            } else {
              throw Exception('Invalid data type: expected Map<String, List<CourseDetailsEntity>>');
            }
          }

          return existingData;
        } else {
          throw Exception('Invalid data type: expected List<Map<String, List<CourseDetailsEntity>>>');
        }
      }

      return []; // Return an empty list if no data is found
    }

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


//
// List<CourseDetailsEntity> deleteFileByIndex(int index, String type, String courseCode) {
//   // Get the correct box based on the file type
//   var box = Hive.box<Map<String, List<CourseDetailsEntity>>>('files');
//
//   // Retrieve the current map of course files for the given type
//   Map<String, List<CourseDetailsEntity>> courseFilesMap = box.get(type) ?? <String, List<CourseDetailsEntity>>{};
//
//   // Check if the courseCode exists in the map
//   if (courseFilesMap.containsKey(courseCode)) {
//     var courseFilesList = courseFilesMap[courseCode]!;
//
//     // Ensure the index is valid before attempting to delete
//     if (index >= 0 && index < courseFilesList.length) {
//       // Remove the file at the specified index
//       deleteCachedFile(courseFilesList[index].path);
//
//       // Delete the file from the list
//       courseFilesList.removeAt(index);
//
//       // Save the updated map back to the Hive box
//       box.put(type, courseFilesMap);
//     } else {
//       print('Invalid index: $index');
//     }
//   } else {
//     print('Course code $courseCode not found in the box.');
//   }
//
//   // Return the updated list of files for the given courseCode
//   return courseFilesMap[courseCode] ?? [];
// }
//



//
// List<CourseDetailsEntity> updateFile(int index, CourseDetailsEntity file) {
//   //String boxName = getBoxName(file.type!);  // Get the correct box name based on type
//   var box = Hive.box<Map<String, List<CourseDetailsEntity>>>('files');
//   String type = file.type!;
//   String courseCode = file.courseCode;  // Get the courseCode from the file object
//   print('Index in hive: $index');
//
//   // Retrieve the current map of files for the type (which contains courseCode -> List<CourseDetailsEntity>)
//   Map<String, List<CourseDetailsEntity>> courseFilesMap = box.get(type) ?? <String, List<CourseDetailsEntity>>{};
//
//   // Check if the list for the courseCode exists and update it
//   if (courseFilesMap.containsKey(courseCode)) {
//     var courseFilesList = courseFilesMap[courseCode]!;
//
//     // // Remove the old file at the given index
//     // deleteCachedFile(courseFilesList[index].path);
//
//     // Update the file at the specified index
//     courseFilesList[index] = file;
//
//     // Save the updated map back to Hive
//     box.put(type, courseFilesMap);
//
//     print('Index in hive after put: $index');
//   }
//
//   // Return the updated list of files for the given courseCode
//   return courseFilesMap[courseCode]!;
// }



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
