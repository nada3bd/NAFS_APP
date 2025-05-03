// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grad_app/models/vedio_model.dart';

// abstract class VideoState {}
// class VideoInitial extends VideoState {}
// class VideoLoading extends VideoState {}
// class VideoLoaded extends VideoState {
//   final List<VideoModel> videos;
//   VideoLoaded(this.videos);
// }
// class VideoError extends VideoState {
//   final String message;
//   VideoError(this.message);
// }

// class VideosCubit extends Cubit<VideoState> {
//   final Dio dio;
//   static const _baseUrl = 'https://www.googleapis.com/youtube/v3';
//   static const _apiKey  = 'AIzaSyDyK7OrLNGUxy85E8qwIuUUT5JpKvJNb-E';

//   VideosCubit(this.dio) : super(VideoInitial());

//   Future<void> fetchByChannelId(String channelId) async {
//     emit(VideoLoading());
//     try {
//       final searchResp = await dio.get(
//         '$_baseUrl/search',
//         queryParameters: {
//           'key': _apiKey,
//           'channelId': channelId,
//           'part': 'snippet',
//           'order': 'date',
//           'maxResults': 20,
//           'type': 'video',
//         },
//       );
//       final items = (searchResp.data['items'] as List)
//           .map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
//           .toList();

//       final ids = items.map((v) => v.id).join(',');
//       final detailsResp = await dio.get(
//         '$_baseUrl/videos',
//         queryParameters: {
//           'key': _apiKey,
//           'id': ids,
//           'part': 'contentDetails',
//         },
//       );
//       final details = detailsResp.data['items'] as List;
//       final durationMap = <String, String>{};
//       for (var item in details) {
//         final id = item['id'] as String;
//         final iso = item['contentDetails']['duration'] as String;
//         durationMap[id] = VideoModel.parseDuration(iso);
//       }

//       final updated = items
//           .map((v) => v.copyWith(duration: durationMap[v.id] ?? '00:00'))
//           .toList();

//       emit(VideoLoaded(updated));
//     } catch (e) {
//       emit(VideoError(e.toString()));
//     }
//   }

 
//   Future<void> fetch() =>
//       fetchByChannelId('UCpuqYFKLkcEryEieomiAv3Q');
  
  
// }
