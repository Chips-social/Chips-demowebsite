import 'package:chips_demowebsite/widgets/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeChip extends StatefulWidget {
  final String youtubeURL;
  const YoutubeChip({super.key, required this.youtubeURL});

  @override
  State<YoutubeChip> createState() => _YoutubeChipState();
}

class _YoutubeChipState extends State<YoutubeChip> {
  late YoutubePlayerController _controller;
  String id = "";
  @override
  void initState() {
    super.initState();
    id = extractYouTubeId(widget.youtubeURL).toString();

    _controller = YoutubePlayerController.fromVideoId(
      videoId: id,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 150,
          width: 260,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: YoutubePlayer(
            controller: _controller,
            aspectRatio: 16 / 9,
          ),
        ),
      ],
    );
  }
}
