import 'dart:io';

import 'package:ditto/bloc/home_screen_bloc.dart';
import 'package:ditto/helper/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {

  final String videoPath;
  final VideoType videoType;

  VideoPlayerWidget({@required this.videoPath, this.videoType});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {

  HomeScreenBloc _homeScreenBloc;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    print(widget.videoType);
    if(widget.videoType == VideoType.NETWORK){
      print("hit this");
      _controller = VideoPlayerController.network(widget.videoPath);
    }
    else{
      print("hit this this");
      _controller = VideoPlayerController.file(File(widget.videoPath));
    }

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _homeScreenBloc = Provider.of<HomeScreenBloc>(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              ),
              StreamBuilder(
                initialData: true,
                stream: _homeScreenBloc.getPlayPauseVideoStream,
                builder: (context, snapshot) {
                  return snapshot.hasData
                    ? AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: snapshot.data ? 1.0 : 0.0,
                    child: Center(
                      child: Container(
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          child: Icon(
                            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Theme.of(context).primaryColor,
                          ),
                          elevation: 0.0,
                          onPressed: () {
                            _homeScreenBloc.getPlayPauseVideoSink.add(!snapshot.data);
                            _controller.value.isPlaying ? _controller.pause() : _controller.play();
                          },
                        ),
                      ),
                    ),
                  )
                  : Container();
                },
              ),
            ],
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
