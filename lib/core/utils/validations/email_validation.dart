String? isEmailValide(String? value) {
  //RegExp(r'^[a-zA-Z0-9_]+@sci\.asu\.edu\.eg$');
  final emailRegExp = RegExp(r'^[a-zA-Z0-9][a-zA-Z0-9_]*@sci\.asu\.edu\.eg$');

  if (value!.trim().isEmpty || value == null) {
    return 'Email cannot be empty.';
  } else if (!emailRegExp.hasMatch(value)) {
    return 'Please enter a valid email address.';
  }
  return null;
}