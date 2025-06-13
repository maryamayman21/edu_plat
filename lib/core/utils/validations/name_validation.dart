String? isNameValid(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name cannot be empty';
  }

  // Regex: two or more words separated by single spaces, with optional single trailing space
  final regExp = RegExp(r"^[A-Za-z]+( [A-Za-z]+)+ ?$");

  if (value.length < 4) {
    return 'Name must be at least 3 characters long';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter a valid name (letters and spaces only)';
  }

  return null;
}