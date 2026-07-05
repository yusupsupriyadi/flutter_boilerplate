import '../../core/error/app_exception.dart';
import '../../domain/models/photo.dart';

/// Raw API representation of a photo (matches the JSONPlaceholder schema).
///
/// Serialization is done manually with `dart:convert` (see the
/// `flutter-implement-json-serialization` skill). It lives in the data layer
/// and is mapped to the domain [Photo] via [toDomain].
class PhotoApiModel {
  const PhotoApiModel({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;

  factory PhotoApiModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'albumId': final int albumId,
        'title': final String title,
        'url': final String url,
        'thumbnailUrl': final String thumbnailUrl,
      } =>
        PhotoApiModel(
          id: id,
          albumId: albumId,
          title: title,
          url: url,
          thumbnailUrl: thumbnailUrl,
        ),
      _ => throw const ParsingException('Invalid Photo JSON shape.'),
    };
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'albumId': albumId,
    'title': title,
    'url': url,
    'thumbnailUrl': thumbnailUrl,
  };

  /// Maps this raw model into the clean domain [Photo].
  Photo toDomain() =>
      Photo(id: id, title: title, thumbnailUrl: thumbnailUrl, imageUrl: url);
}
