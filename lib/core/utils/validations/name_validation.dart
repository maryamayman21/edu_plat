String? isNameValid(String? value) {
  final regExp = RegExp(r"^[A-Za-z]+(?:[ '-][A-Za-z]+)*$");
  if (value!.trim().isEmpty || value == null) {
    return 'Name cannot be empty';
  } else if (value.length < 3) {
    return 'Name must be at least 3 characters long';
  }else if (!regExp.hasMatch(value)) {
    return 'Please enter a valid name';
  }
  return null;
}
