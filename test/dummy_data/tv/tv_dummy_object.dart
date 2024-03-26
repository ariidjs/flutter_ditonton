import 'package:ditonton/data/models/tv/tv_table.dart';
import 'package:ditonton/domain/entities/movies/genre.dart';
import 'package:ditonton/domain/entities/tv/episode.dart';
import 'package:ditonton/domain/entities/tv/season.dart';
import 'package:ditonton/domain/entities/tv/season_detail.dart';
import '../../../core/lib/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';

final testTv = TvShow(
  backdropPath: '/5DUMPBSnHOZsbBv81GFXZXvDpo6.jpg',
  firstAirDate: DateTime.parse('2022-10-12'),
  genreIds: [16, 10759, 10765, 35],
  id: 114410,
  name: 'Chainsaw Man',
  originCountry: ['JP'],
  originalLanguage: 'ja',
  originalName: 'チェンソーマン',
  overview:
      'Denji has a simple dream—to live a happy and peaceful life, spending time with a girl he likes. This is a far cry from reality, however, as Denji is forced by the yakuza into killing devils in order to pay off his crushing debts. Using his pet devil Pochita as a weapon, he is ready to do anything for a bit of cash.',
  popularity: 1004.662,
  posterPath: '/npdB6eFzizki0WaZ1OvKcJrWe97.jpg',
  voteAverage: 8.6,
  voteCount: 340,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'name')],
  homepage: 'homepage',
  id: 1,
  inProduction: false,
  languages: ['us'],
  lastAirDate: null,
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 2,
  seasons: [
    Season(
      airDate: null,
      episodeCount: 1,
      id: 2,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 2,
    )
  ],
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 2.2,
  posterPath: 'posterPath',
  productionCompanies: ['productionCompanies'],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 2.1,
  voteCount: 22,
);

final testWatchlistTv = TvShow.watchlist(
  id: 1,
  name: "name",
  overview: "overview",
  posterPath: "posterPath",
);

final testTvTable = TvTable(
  id: 1,
  name: "name",
  posterPath: "posterPath",
  overview: "overview",
);

final testTvMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};

final testTvSeasonDetail = SeasonDetail(
  id: '1',
  airDate: 'airDate',
  episodes: [
    Episode(
      airDate: 'airDate',
      episodeNumber: 2,
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: '1',
      runtime: 3,
      seasonNumber: 1,
      showId: 2,
      stillPath: 'stillPath',
      voteAverage: 4.2,
      voteCount: 44,
      crew: [],
      guestStars: [],
    )
  ],
  name: 'name',
  overview: 'overview',
  seasonDetailResponseId: 2,
  posterPath: 'posterPath',
  seasonNumber: 2,
);
