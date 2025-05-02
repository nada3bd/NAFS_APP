import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/vedio_cubit.dart';
import 'package:grad_app/models/vedio_model.dart';
import 'package:grad_app/widgets/appbaar.dart';
import 'package:grad_app/widgets/vedio_tile.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key});

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  @override
  void initState() {
    super.initState();
    context.read<VideoCubit>().fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Videos'),
      body: BlocBuilder<VideoCubit, List<VideoModel>>(
        builder: (context, videos) {
          if (videos.isEmpty) return const Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) => VideoTile(
              video: videos[index],
              onTap: () {
                // افتح مشغل الفيديو
              },
            ),
          );
        },
      ),
    );
  }
}
