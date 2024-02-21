import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeChip extends StatefulWidget {
  final String youtubeURL;
  const YoutubeChip({super.key, required this.youtubeURL});

  @override
  State<YoutubeChip> createState() => _YoutubeChipState();
}

class _YoutubeChipState extends State<YoutubeChip> {
  late final YoutubePlayerController controller;

  @override
  void initState() {
    String videoId;
    if (widget.youtubeURL == "null") {
      videoId = 'iLnmTe5Q2Qw';
    } else {
      videoId = YoutubePlayer.convertUrlToId(widget.youtubeURL)!;
    }

    controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
          onReady: () {
            // controller.addListener(listener);
          },
        ),
      ],
    );
  }
}
