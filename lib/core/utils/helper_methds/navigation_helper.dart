
import 'package:flutter/cupertino.dart';
void selectedCourse({context , page , argument}) {
  Navigator.of(context).pushNamed(page, arguments: argument);
}