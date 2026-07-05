import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/app_constants.dart';
import '../../core/error/app_exception.dart';
import '../../core/network/api_client.dart';
import '../../core/providers/app_providers.dart';
import '../../domain/models/photo.dart';
import '../models/photo_api_model.dart';

part 'photo_repository.g.dart';

/// Single source of truth for [Photo] data.
///
/// Consumes [ApiClient] (a Service), transforms the raw [PhotoApiModel]s into
/// domain [Photo]s, and is the only class the presentation layer talks to for
/// photos.
class PhotoRepository {
  PhotoRepository(this._apiClient);

  final ApiClient _apiClient;

  /// Fetches a page of photos and maps them to domain models.
  Future<List<Photo>> getPhotos({
    int limit = AppConstants.defaultPageSize,
  }) async {
    final data = await _apiClient.get('/photos', query: {'_limit': limit});
    if (data is! List) {
      throw const ParsingException('Expected a list of photos.');
    }
    return data
        .cast<Map<String, dynamic>>()
        .map(PhotoApiModel.fromJson)
        .map((model) => model.toDomain())
        .toList();
  }
}

/// Exposes [PhotoRepository] through Riverpod (dependency injection).
@riverpod
PhotoRepository photoRepository(Ref ref) =>
    PhotoRepository(ref.watch(apiClientProvider));
