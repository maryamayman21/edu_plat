extension TimeExtension on DateTime {
  String get ToFormate {
    return "$day/$month/$year";
  }

  String get ToFormateTime {
    String period = hour >= 12 ? 'PM' : 'AM';
    int hour12 = hour % 12 == 0 ? 12 : hour % 12;
    String minuteStr = minute.toString().padLeft(2, '0');
    return "$hour12:$minuteStr $period";
  }
}
