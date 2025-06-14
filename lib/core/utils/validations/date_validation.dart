bool isDateTimeInPast(DateTime dateTimeToCheck) {
  final now = DateTime.now();

  // Create comparable DateTime objects including minutes and seconds
  final comparableNow = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
      now.second
  );

  final comparableCheck = DateTime(
      dateTimeToCheck.year,
      dateTimeToCheck.month,
      dateTimeToCheck.day,
      dateTimeToCheck.hour,
      dateTimeToCheck.minute,
      dateTimeToCheck.second
  );

  return comparableCheck.isBefore(comparableNow);
}