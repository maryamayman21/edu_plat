import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class NetworkVideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String videoName;

  const NetworkVideoPlayerScreen({Key? key, required this.videoUrl, required this.videoName}) : super(key: key);

  @override
  _NetworkVideoPlayerScreenState createState() => _NetworkVideoPlayerScreenState();
}

class _NetworkVideoPlayerScreenState extends State<NetworkVideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
      await _videoPlayerController.initialize(); // Initialize the video
      setState(() {
        _isLoading = false;
      });
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        placeholder: Container(
          color: Colors.black,
        ),
        allowFullScreen: true,
        allowMuting: true,
        allowPlaybackSpeedChanging: true,

      );
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    if(!_hasError) {
      _chewieController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.videoName),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator() // Show loader while initializing
            : _hasError
            ? const Text('Failed to load video') // Show error message
            : Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }
}