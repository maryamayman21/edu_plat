import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

String getUserFriendlyErrorMessage(dynamic error) {
  if (error is SocketException || error is TimeoutException) {
    return 'No internet connection. Please check your network and try again.';
  } else if (error is HttpException) {
    return 'Media could not be reached (Server error).';
  } else if (error is FormatException) {
    return 'Invalid media format. Please try another file.';
  } else if (error is PlatformException) {
    return 'Cant access media.';
  }
  else {
    return 'Failed to load media. Please try again later.';
  }
}