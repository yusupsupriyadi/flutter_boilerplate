import 'package:flutter_boilerplate/core/error/app_exception.dart';
import 'package:flutter_boilerplate/data/models/photo_api_model.dart';
import 'package:flutter_boilerplate/domain/models/photo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const json = <String, dynamic>{
    'albumId': 1,
    'id': 1,
    'title': 'accusamus beatae ad facilis cum similique qui sunt',
    'url': 'https://via.placeholder.com/600/92c952',
    'thumbnailUrl': 'https://via.placeholder.com/150/92c952',
  };

  group('PhotoApiModel', () {
    test('fromJson parses a valid payload', () {
      final model = PhotoApiModel.fromJson(json);

      expect(model.id, 1);
      expect(model.albumId, 1);
      expect(model.title, json['title']);
      expect(model.url, json['url']);
      expect(model.thumbnailUrl, json['thumbnailUrl']);
    });

    test('toJson round-trips back to the original map', () {
      final model = PhotoApiModel.fromJson(json);

      expect(model.toJson(), json);
    });

    test('toDomain maps into a clean Photo', () {
      final photo = PhotoApiModel.fromJson(json).toDomain();

      expect(photo, isA<Photo>());
      expect(photo.imageUrl, json['url']);
      expect(photo.thumbnailUrl, json['thumbnailUrl']);
    });

    test('fromJson throws ParsingException on a malformed payload', () {
      expect(
        () => PhotoApiModel.fromJson(const {'id': 'not-an-int'}),
        throwsA(isA<ParsingException>()),
      );
    });
  });
}
