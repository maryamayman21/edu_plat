String?isEmailValide(String? value) {
  final emailRegExp = RegExp(
      r'^(?:[a-z]+_[a-z]+|\d+)@sci\.asu\.edu\.eg$|^[a-zA-Z0-9._%+-]+@gmail\.com$');

  if (value == null || value.trim().isEmpty) {
    return 'Email cannot be empty';
  } else if (!emailRegExp.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}