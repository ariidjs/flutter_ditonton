part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  const TvState();

  @override
  List<Object> get props => [];
}

class TvLoading extends TvState {}

class TvEmpty extends TvState {}

class TvError extends TvState {
  final String message;
  const TvError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSuccess extends TvState {
  final List<TvShow> tvList;
  const TvSuccess(this.tvList);

  @override
  List<Object> get props => [tvList];
}

class TvDetailSuccess extends TvState {
  final TvDetail tvDetail;
  const TvDetailSuccess(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class TvSeasonDetailSuccess extends TvState {
  final SeasonDetail tvSeason;
  const TvSeasonDetailSuccess(this.tvSeason);

  @override
  List<Object> get props => [tvSeason];
}

class TvWatchlistStatus extends TvState {
  final bool status;

  const TvWatchlistStatus(this.status);

  @override
  List<Object> get props => [status];
}

class WatchlistTvMessage extends TvState {
  final String message;

  const WatchlistTvMessage(this.message);

  @override
  List<Object> get props => [message];
}
