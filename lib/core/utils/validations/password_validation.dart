String? isPasswordValid(String? value) {
  if (value!.trim().isEmpty || value == null) {
    return 'Password cannot be empty';
  } else if (value.length < 8 && value.length > 20) {
    return 'Password must be at least 8 characters and less than 20 characters';
  }
  return null;
}
