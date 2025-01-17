String? isEmailValide(String? value) {
  final emailRegExp =RegExp(r'^(?:[a-z]+_[a-z]+|\d+)@sci\.asu\.edu\.eg$');
  if (value!.trim().isEmpty || value == null) {
    return 'Email cannot be empty';
  } else if (!emailRegExp.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}