import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/vedio_cubit.dart';
import 'package:grad_app/views/video_player.dart';
import 'package:grad_app/widgets/appbaar.dart';
import 'package:grad_app/widgets/vedio_tile.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key});

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  static const String _channelId = 'UCpuqYFKLkcEryEieomiAv3Q';

  @override
  void initState() {
    super.initState();
    context.read<VideosCubit>().fetchByChannelId(_channelId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Videos'),
      body: BlocBuilder<VideosCubit, VideoState>(
        builder: (context, state) {
          if (state is VideoLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.teal));
          } else if (state is VideoLoaded) {
            final videos = state.videos;
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return VideoTile(
                  video: video,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoPlayerPage(videoUrl: video.videoUrl),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is VideoError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
