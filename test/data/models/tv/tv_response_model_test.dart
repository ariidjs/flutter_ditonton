import 'dart:convert';

import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: '/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg',
    firstAirDate: DateTime.parse('1952-12-26'),
    genreIds: [10763],
    id: 94722,
    name: 'Tagesschau',
    originCountry: ['DE'],
    originalLanguage: 'de',
    originalName: 'Tagesschau',
    overview:
        'German daily news program, the oldest still existing program on German television.',
    popularity: 5024.078,
    posterPath: '/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg',
    voteAverage: 6.915,
    voteCount: 194,
  );
  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test(
      "should return a valid model from JSON",
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(readJson('dummy_data/tv/now_playing_tv.json'));
        // act
        final result = TvResponse.fromJson(jsonMap);
        // assert
        expect(result, tTvResponseModel);
      },
    );
  });

  group('toJson', () {
    test("should return a JSON map containing proper data", () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
            "genre_ids": [10763],
            "id": 94722,
            "origin_country": ["DE"],
            "original_language": "de",
            "original_name": "Tagesschau",
            "overview":
                "German daily news program, the oldest still existing program on German television.",
            "popularity": 5024.078,
            "poster_path": "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
            "first_air_date": "1952-12-26",
            "name": "Tagesschau",
            "vote_average": 6.915,
            "vote_count": 194
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
