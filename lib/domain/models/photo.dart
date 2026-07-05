import 'package:flutter/foundation.dart';

/// Clean, immutable domain model for a photo.
///
/// The UI only ever depends on this type — never on the raw API model.
@immutable
class Photo {
  const Photo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.imageUrl,
  });

  final int id;
  final String title;
  final String thumbnailUrl;
  final String imageUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Photo &&
          other.id == id &&
          other.title == title &&
          other.thumbnailUrl == thumbnailUrl &&
          other.imageUrl == imageUrl;

  @override
  int get hashCode => Object.hash(id, title, thumbnailUrl, imageUrl);

  @override
  String toString() => 'Photo(id: $id, title: $title)';
}
