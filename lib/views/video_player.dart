// import 'package:flutter/material.dart';
// import 'package:grad_app/widgets/appbaar.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class VideoPlayerPage extends StatefulWidget {
//   final String videoUrl; 
 
//   const VideoPlayerPage({
//     super.key,
//     required this.videoUrl,
//   });

//   @override
//   VideoPlayerPageState createState() => VideoPlayerPageState();
// }

// class VideoPlayerPageState extends State<VideoPlayerPage> {
//   late YoutubePlayerController _ytController;
 

//   @override
//   void initState() {
//     super.initState();
//     final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;
//     _ytController = YoutubePlayerController(
//       initialVideoId: videoId,
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _ytController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var scaffold = Scaffold(
//       appBar: const CustomAppBar(title: 'Video'),
//       body: Center(
//         child: YoutubePlayer(
//           controller: _ytController,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Colors.teal,
//         ),
//       ),
//     );
//     return scaffold;
//   }
// }
