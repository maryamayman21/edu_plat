part of 'screenshot_bloc.dart';

@immutable
sealed class ScreenshotState {}

final class ScreenshotInitial extends ScreenshotState {}
class ScreenshotEnabled extends ScreenshotState {}

class ScreenshotDisabled extends ScreenshotState {}