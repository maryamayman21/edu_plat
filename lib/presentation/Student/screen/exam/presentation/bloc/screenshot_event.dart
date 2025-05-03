part of 'screenshot_bloc.dart';

@immutable
sealed class ScreenshotEvent {}
class EnableSecureMode extends ScreenshotEvent {}

class DisableSecureMode extends ScreenshotEvent {}
