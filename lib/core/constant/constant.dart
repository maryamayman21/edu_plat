class ApiConstants {
  static const String baseUrl = 'https://great-hot-impala.ngrok-free.app';
  static const String registerEndpoint  = '/api/Accounts/Register';
  static const String loginEndpoint  = '/api/Accounts/Login';
  static const String verifyEmailEndpoint  = '/api/Accounts/VerifyEmail';
  static const String forgetPassEndpoint  = '/api/Accounts/forgot-password';
  static const String validateOtpEndpoint  = '/api/Accounts/validate-otp';
  static const String resetPasswordEndpoint  = '/api/Accounts/reset-password';
  static const String profilePhotoEndpoint  = '/api/Profile/profile-pic';
  static const String userProfileEndpoint  = '/api/Profile/Profile';
  static const String userUpdatePhoneNumberEndpoint  = '/api/Profile/changePhoneNumber';
  static const String userFetchPhoneNumberEndpoint  = '/api/Profile/phone-number';
  static const String profileResetPasswordEndpoint  = '/api/Profile/changePassword';
  static const String courseRegistrationEndPoint  = '/api/Course/Courses-semster/';
  static const String  registerCoursesEndPoint  = '/api/Course/Add-Doctor-Course';
  static const String  deleteCourseEndPoint  = '/api/Course/Delete-Course';
  static const String  getCoursesEndPoint  = '/api/Course/Get-doctor-courses';
  static const String  getAllNotesEndPoint  = '/api/Todo/GetAll';
  static const String  addNoteEndPoint  = '/api/Todo/Add-new-todo';
  static const String  deleteNoteEndPoint  = '/api/Todo/Delete/';
  static const String  updateNoteEndPoint  = '/api/Todo/Update/';
  static const String uploadFileEndpoint = '/api/Materials/UploadFile/Doctors';
  static const String updateFileEndpoint = '/api/Materials/updateFile';
  static const String deleteFileEndpoint = '/api/Materials/delete/';
  static const String fetchCourseMaterialByType = '/api/Materials/Get-Material-ByType/courseCode/typeFile?courseCode=COMP201&typeFile=Lectures';
  static const String  studentregisterCoursesEndPoint  = '/api/StudentCourse/Register';
  static const String  studentCoursesEndPoint  = '/api/StudentCourse/MyCourses';
  static const String  studentdeleteCourseEndPoint= '/api/StudentCourse/DeleteCourse';
  static const String  doctorCreateExamEndpoint= '/api/Exams/CreateExamOnline&Offline';
 static const String  doctorGetExamsEndpoint= '/api/Exams/GetUserExams?isFinishedExam';
static const String  doctorDeleteExamEndpoint= '/api/Exams/DeleteExam';

}