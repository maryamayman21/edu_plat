import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum VideoPlayerType {
  network,
  asset,
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget._({
    required this.url,
    required this.height,
    required this.width,
    required this.type,
  });

  factory VideoPlayerWidget.network({
    required String? url,
    required double? height,
    required double? width,
  }) {
    return VideoPlayerWidget._(
      url: url,
      height: height,
      width: width,
      type: VideoPlayerType.network,
    );
  }

  factory VideoPlayerWidget.asset({
    required String? url,
    required double? height,
    required double? width,
  }) {
    return VideoPlayerWidget._(
      url: url,
      height: height,
      width: width,
      type: VideoPlayerType.asset,
    );
  }

  final String? url;
  final double? height;
  final double? width;
  final VideoPlayerType type;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController controller;
  bool isInitializing = true;
  ValueNotifier<bool> isBufferingNotifier = ValueNotifier(false);
  ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    controller = widget.type == VideoPlayerType.network
        ? VideoPlayerController.networkUrl(Uri.parse(widget.url ?? ""))
        : VideoPlayerController.file(File(widget.url ?? ""));

    controller.initialize().then((_) {
      controller.addListener(_listenTimeLine);
      setState(() => isInitializing = false);
      controller.seekTo(const Duration(milliseconds: 1));
    }).catchError((error) {
      setState(() => isInitializing = false);
      debugPrint(error);
    });
  }

  @override
  void dispose() {
    controller.removeListener(_listenTimeLine);
    controller.dispose();
    isPlayingNotifier.dispose();
    isBufferingNotifier.dispose();
    super.dispose();
  }

  void _listenTimeLine() {
    isBufferingNotifier.value = controller.value.isBuffering;
    if (controller.value.position.inMilliseconds == controller.value.duration.inMilliseconds) {
      isPlayingNotifier.value = false;
      controller.seekTo(const Duration(milliseconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width?.w,
      height: widget.height?.h,
      color: Colors.blue,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
          if (isInitializing)
            SizedBox(
              height: 32.h,
              width: 32.w,
              child: const CircularProgressIndicator(color: Colors.white),
            ),
          ValueListenableBuilder<bool>(
            valueListenable: isBufferingNotifier,
            builder: (context, isBuffering, _) {
              return isBuffering
                  ? SizedBox(
                height: 32.h,
                width: 32.w,
                child: const CircularProgressIndicator(),
              )
                  : const SizedBox();
            },
          ),
          GestureDetector(
            onTap: () {
              if (isPlayingNotifier.value) {
                controller.pause();
              } else {
                controller.play();
              }
              isPlayingNotifier.value = !isPlayingNotifier.value;
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: isPlayingNotifier,
            builder: (context, isPlaying, _) {
              return !isPlaying
                  ? GestureDetector(
                onTap: () {
                  isPlayingNotifier.value = !isPlayingNotifier.value;
                  isPlayingNotifier.value ? controller.play() : controller.pause();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(10.w),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    size: 24.sp,
                    color: Colors.white,
                  ),
                ),
              )
                  : const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
