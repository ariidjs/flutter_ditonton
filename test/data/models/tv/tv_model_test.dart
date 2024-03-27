import 'package:flutter_test/flutter_test.dart';
import 'package:core/data/models/tv/tv_models.dart';
import 'package:tvshow/domain/entities/tv_show.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: 'backdropPath',
    firstAirDate: DateTime.parse('2024-03-20'),
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTv = TvShow(
    backdropPath: 'backdropPath',
    firstAirDate: DateTime.parse('2024-03-20'),
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  test(
    "should be a subclass of Tv entity",
    () async {
      final result = tTvModel.toEntity();
      expect(result, tTv);
    },
  );
}
