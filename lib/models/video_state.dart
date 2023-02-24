


import 'package:flutter_ui/models/video.dart';

class VideoState{

  final bool isLoaded;
  final List<Video> videos;
  final String errorMessage;

  VideoState({
    required this.errorMessage,
    required this.isLoaded,
    required this.videos
  });

  VideoState copyWith({
    bool? isLoaded,
    String? errorMessage,
    List<Video>? videos,

  }) {
    return VideoState(
        errorMessage: errorMessage ??  this.errorMessage,
        isLoaded: isLoaded ?? this.isLoaded,
        videos: videos ?? this.videos
    );
  }



}