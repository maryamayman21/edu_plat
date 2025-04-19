

import 'package:edu_platt/core/localDB/hive/files.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';



abstract class CourseDetailsLocalDataSource {
  Future<List<CourseDetailsEntity>> fetchCourseFiles(String type , String courseCode);
 Future<List<CourseDetailsEntity>> saveCourseFiles(List<CourseDetailsEntity> courseFiles);
 Future <int?> getCourseId(int index, String type, String courseCode);
  Future<String?> getCourseFilePath(int index , String type, String courseCode);
  Future<String?> getCourseFileName(int index , String type, String courseCode);
  Future<List<CourseDetailsEntity>> deleteCourseFiles(int index, String type, String courseCode);
  Future<List<CourseDetailsEntity>> updateCourseFile(int index, CourseDetailsEntity courseFile);


}

class CourseDetailsLocalDataSourceImpl extends CourseDetailsLocalDataSource {
  @override
 Future <List<CourseDetailsEntity>> fetchCourseFiles(String type , String courseCode)async {
   print('Fetched from local ');
      List<CourseDetailsEntity> courseFiles = HiveService.getFiles(boxName: type, key: courseCode);
      return courseFiles.isEmpty ? [] : courseFiles;
  }
  @override
  Future<List<CourseDetailsEntity>> saveCourseFiles(List<CourseDetailsEntity> courseFile)async {

    //need to check if there a file is already present
     print('Inside ');
     print('Add id ${courseFile.first.id}');
    List<CourseDetailsEntity> courseFiles = await HiveService.addFile(fileDataList: courseFile);
     print('Saved  in local  ');
    return courseFiles;
  }
  @override
  Future<List<CourseDetailsEntity>> deleteCourseFiles(int index, String type, String courseCode)async {
    List<CourseDetailsEntity> courseFiles = await HiveService.deleteFile(
        index:   index, type:  type, courseCode: courseCode);
    return courseFiles.isEmpty ? [] : courseFiles;
  }
  @override
  Future<List<CourseDetailsEntity>> updateCourseFile(int index, CourseDetailsEntity courseFile) async{
    List<CourseDetailsEntity> courseFiles = await HiveService.updateFile( index: index,updatedFile:  courseFile);
    return courseFiles;
  }
  @override
  Future<int?> getCourseId(int index, String type, String courseCode)async {

     int? id =  await HiveService.getFileId( index: index, type: type,courseCode: courseCode);
     print('File id $id');
     return id;
  }
  @override
  Future<String?> getCourseFilePath(int index, String type, String courseCode)async{
    return await HiveService.getFilePath(index: index, type: type, courseCode: courseCode);


  }

  @override
  Future<String?> getCourseFileName(int index, String type, String courseCode)async {
    String? fileName = await  HiveService.getFileName( index: index,type:  type, courseCode:  courseCode);
    return fileName;
  }

}
