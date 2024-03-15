import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class XVideoPlayerFile extends StatefulWidget {
  const XVideoPlayerFile({super.key, required this.videopath});
  final String videopath;

  @override
  State<XVideoPlayerFile> createState() => _VideoPlayerFileState();
}

class _VideoPlayerFileState extends State<XVideoPlayerFile> {
  late VideoPlayerController _controller;
  late Future<void> _video;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videopath));
    _video = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _video,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
