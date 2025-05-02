import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:grad_app/models/vedio_model.dart';

class VideoCubit extends Cubit<List<VideoModel>> {
  VideoCubit() : super([]);

  final Dio dio = Dio();
  final String apiKey = 'AIzaSyDyK7OrLNGUxy85E8qwIuUUT5JpKvJNb-E';

  Future<void> fetchVideos() async {
    try {
      final response = await dio.get(
        'https://www.googleapis.com/youtube/v3/search',
        queryParameters: {
          'part': 'snippet',
          'q': 'therapy', 
          'type': 'video',
          'maxResults': 10,
          'key': apiKey,
          'relevanceLanguage': 'ar',
        },
      );

      final List data = response.data['items'];
      List<VideoModel> videos = [];

      for (var item in data) {
        final videoId = item['id']['videoId'];

        final duration = await fetchVideoDuration(videoId);

        videos.add(
          VideoModel.fromJson(item, duration),
        );
      }

      emit(videos);
    } catch (e) {
      emit([]);
    }
  }

  Future<String> fetchVideoDuration(String videoId) async {
    final response = await dio.get(
      'https://www.googleapis.com/youtube/v3/videos',
      queryParameters: {
        'part': 'contentDetails',
        'id': videoId,
        'key': apiKey,
      },
    );

    final isoDuration = response.data['items'][0]['contentDetails']['duration'];
    return _parseDuration(isoDuration);
  }

  String _parseDuration(String iso) {
    final regex = RegExp(r'PT(?:(\d+)M)?(?:(\d+)S)?');
    final match = regex.firstMatch(iso);

    final minutes = match?.group(1) ?? '0';
    final seconds = match?.group(2) ?? '0';

    return '$minutes:${seconds.padLeft(2, '0')}';
  }
}
