String? isPasswordValid(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required.';
  }

  // Regex explanation:
  // ^                        Start of string
  // (?=.*[a-z])             At least one lowercase letter
  // (?=.*[A-Z])             At least one uppercase letter
  // (?=.*\d)                At least one digit
  // (?=.*[@\$!%*?&#])       At least one special character
  // [A-Za-z\d@\$!%*?&#]     Allowed characters
  // {8,15}                  Length between 8 and 15
  // $                       End of string
  final regExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,15}$');

  if (!regExp.hasMatch(value)) {
    return 'Password must be 8-15 characters long, and include at least one lowercase letter, one uppercase letter, one digit, and one special character (@\$!%*?&#).';
  }

  return null;
}