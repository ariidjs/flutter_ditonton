import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv/season_detail.dart';
import 'package:core/domain/entities/tv/tv_show.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<TvShow>>> getOnTheAirTvShows();
  Future<Either<Failure, List<TvShow>>> getPopularTvShows();
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();
  Future<Either<Failure, TvDetail>> getTvShowDetail(int id);
  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id);
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tv);
  Future<bool> isAddedToWatchlistTv(int id);
  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows();
  Future<Either<Failure, SeasonDetail>> getSeasonDetail(
      int tvId, int seasonNumber);
}
