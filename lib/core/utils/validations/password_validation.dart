String? isPasswordValid(String? value) {
 final regExp  =  RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$');
  if (value!.trim().isEmpty || value == null) {
    return 'Password cannot be empty';
  } else if (value.length < 8 || value.length > 15) {
    return 'Password must be at least 8 characters and at most 15 characters';
  }else if (!regExp.hasMatch(value)){
      return "Not valid password";
  }
  return null;
}
