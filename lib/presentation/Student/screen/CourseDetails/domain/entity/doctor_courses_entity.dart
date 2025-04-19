class DoctorCoursesEntity {
 final String doctorName;
 final String doctorId;

 DoctorCoursesEntity({required this.doctorName, required this.doctorId});

 // // Convert a DoctorCoursesEntity object to a JSON map
 // Map<String, dynamic> toJson() {
 //  return {
 //   'doctorName': doctorName,
 //   'doctorId': doctorId,
 //  };
 // }

 // Create a DoctorCoursesEntity object from a JSON map
 factory DoctorCoursesEntity.fromJson(Map<String, dynamic> json) {
  return DoctorCoursesEntity(
   doctorName: json['name'] as String,
   doctorId: json['doctorId'] as String,
  );
 }
}
