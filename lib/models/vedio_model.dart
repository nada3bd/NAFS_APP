// class VideoModel {
//   final String id;
//   final String title;
//   final String thumbnailUrl;
//   final String videoUrl;
//   final String duration;

//   VideoModel({
//     required this.id,
//     required this.title,
//     required this.thumbnailUrl,
//     required this.videoUrl,
//     required this.duration,
//   });

//   factory VideoModel.fromJson(Map<String, dynamic> json) {
//     final snippet = json['snippet'];
//     final videoId = (json['id'] is Map)
//         ? json['id']['videoId'] as String
//         : json['id'] as String;
//     return VideoModel(
//       id: videoId,
//       title: snippet['title'] as String,
//       thumbnailUrl: snippet['thumbnails']['medium']['url'] as String,
//       videoUrl: 'https://www.youtube.com/watch?v=$videoId',
//       duration: '',
//     );
//   }

//   VideoModel copyWith({String? duration}) {
//     return VideoModel(
//       id: id,
//       title: title,
//       thumbnailUrl: thumbnailUrl,
//       videoUrl: videoUrl,
//       duration: duration ?? this.duration,
//     );
//   }

//   static String parseDuration(String isoDuration) {
//     final regex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?');
//     final match = regex.firstMatch(isoDuration);
//     if (match == null) return '00:00';
//     final hours = int.parse(match.group(1) ?? '0');
//     final minutes = int.parse(match.group(2) ?? '0');
//     final seconds = int.parse(match.group(3) ?? '0');
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     if (hours > 0) {
//       return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
//     } else {
//       return '${twoDigits(minutes)}:${twoDigits(seconds)}';
//     }
//   }
// }
