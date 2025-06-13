bool isDateTimeInPast(DateTime dateTimeToCheck) {
  // Get current date and time
  final now = DateTime.now();

  // Create comparable DateTime objects with only year, month, day, and hour
  final comparableNow = DateTime(now.year, now.month, now.day, now.hour);
  final comparableCheck = DateTime(
      dateTimeToCheck.year,
      dateTimeToCheck.month,
      dateTimeToCheck.day,
      dateTimeToCheck.hour
  );

  // Check if the comparableCheck is before comparableNow
  return comparableCheck.isBefore(comparableNow);
}