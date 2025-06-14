String? isNameValid(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Name cannot be empty';
  }

  // Check length after trimming (original requirement: at least 3 chars)
  if (value.trim().length < 3) {
    return 'Name must be at least 3 characters long';
  }

  // Original regex modified to allow leading spaces
  // Allows:
  // - Leading spaces
  // - One or more words (letters only)
  // - Separated by single spaces
  // - Optional single trailing space
  final regExp = RegExp(r"^ *[A-Za-z]+( [A-Za-z]+)* *$");

  if (!regExp.hasMatch(value)) {
    return 'Please enter a valid name (letters and spaces only)';
  }

  return null;
}