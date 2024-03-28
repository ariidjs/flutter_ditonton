part of 'tv_bloc.dart';

abstract class TvEvent {
  const TvEvent();
}

class OnTheAir extends TvEvent {}

class PopularTv extends TvEvent {}

class TopRatedTv extends TvEvent {}

class TvSeasonDetail extends TvEvent {
  final int id;
  final int seasonNumber;
  const TvSeasonDetail(this.id, this.seasonNumber);
}

class TvRecommendations extends TvEvent {
  final int id;

  const TvRecommendations(this.id);
}

class TvDetails extends TvEvent {
  final int id;

  const TvDetails(this.id);
}

class WatchlistTv extends TvEvent {}

class WatchlistStatusTv extends TvEvent {
  final int id;

  const WatchlistStatusTv(this.id);
}

class SaveTvWatchlist extends TvEvent {
  final TvDetail tvDetail;
  const SaveTvWatchlist(this.tvDetail);
}

class RemoveTvWatchlist extends TvEvent {
  final TvDetail tvDetail;

  const RemoveTvWatchlist(this.tvDetail);
}

class SearchTvQuery extends TvEvent {
  final String query;

  const SearchTvQuery(this.query);
}
