import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:no_screenshot/no_screenshot.dart';

part 'screenshot_event.dart';
part 'screenshot_state.dart';

class ScreenshotBloc extends Bloc<ScreenshotEvent, ScreenshotState> {
  final NoScreenshot _noScreenshot = NoScreenshot();
  ScreenshotBloc() : super(ScreenshotInitial()) {


    on<EnableSecureMode>((event, emit) async {
      await _noScreenshot.screenshotOff();
      print('Screenshot mode off');
      emit(ScreenshotEnabled());
    });

    on<DisableSecureMode>((event, emit) async {
      await _noScreenshot.screenshotOn();
      print('Screenshot mode on');
      emit(ScreenshotDisabled());
    });
  }

  @override
  Future<void> close() async{
    await _noScreenshot.screenshotOn();
    return super.close();
  }
}
