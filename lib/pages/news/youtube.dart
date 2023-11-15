

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Youtube extends StatefulWidget {
  const Youtube({super.key});

  @override
  State<Youtube> createState() => _nameState();
}

class _nameState extends State<Youtube> {
   YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    

    
    _controller = YoutubePlayerController(initialVideoId: 'Tb9k9_Bo-G4',
    flags: const YoutubePlayerFlags(
      mute: false,
      autoPlay: true,
      loop: false
    )
    );
  }

   @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Youtube Player"),
          ) ,
          body: player,
        );
      },
    );
  }

}
