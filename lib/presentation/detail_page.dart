import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/providers/video_provider.dart';
import 'package:pod_player/pod_player.dart';

import '../models/movie.dart';



class DetailPage extends ConsumerWidget {
  final Movie movie;
  DetailPage(this.movie);
  @override
  Widget build(BuildContext context, ref) {
    final videoData = ref.watch(videoProvider(movie.id));
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(movie.poster_path), fit: BoxFit.fill)
          ),
          child: ListView(
            children: [
              if(videoData.videos.isNotEmpty) PlayVideoFromNetwork(videoData.videos[0].key),
              if(videoData.errorMessage.isNotEmpty) Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(videoData.errorMessage, style: TextStyle(fontSize: 17.sp, color: Colors.black),),
              ),
            ],
          ),
        )
    );
  }
}



class PlayVideoFromNetwork extends StatefulWidget {
  final String keys;
  PlayVideoFromNetwork(this.keys);
  @override
  State<PlayVideoFromNetwork> createState() => _PlayVideoFromNetworkState();
}

class _PlayVideoFromNetworkState extends State<PlayVideoFromNetwork> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/${widget.keys}'),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: true,
            // isLooping: false,
            videoQualityPriority: [1080, 720]
        )
    )..initialise();


    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(controller: controller,
    );
  }
}