class User{
 String? name;
 String? email;
 String? password;
 List<dynamic>? role;
 String? phoneNumber;

 //profile

 User.fromJson(Map<String, dynamic> json) {
   name = json['name'];
   email = json['email'];
   password = json['password'];
   role = json['role'] != null ? List<dynamic>.from(json['wishlist']) : null;
 }

 Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = <String, dynamic>{};
   data['name'] = name;
   data['email'] = email;
   data['password'] = password;
   data['role'] = role;
   return data;
 }








}