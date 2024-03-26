import 'tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:core/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/domain/entities/genre.dart';
import 'package:tvshow/domain/entities/tv_show.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';
import 'package:tvshow/domain/entities/tv_detail.dart';
import 'package:tvshow/domain/entities/season_detail.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';



class TvSeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/season_detail_tv';
  final TvDetail tv;
  final int seasonNumber;

  const TvSeasonDetailPage({
    super.key,
    required this.tv,
    required this.seasonNumber,
  });

  @override
  State<TvSeasonDetailPage> createState() => _TVSeasonDetailPageState();
}

class _TVSeasonDetailPageState extends State<TvSeasonDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<TvSeasonDetailBloc>()
          .add(TvSeasonDetail(widget.tv.id, widget.seasonNumber));
      context.read<TvRecommendationBloc>().add(TvRecommendations(widget.tv.id));
      context.read<TvWatchlistBloc>().add(WatchlistStatusTv(widget.tv.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeasonDetailBloc, TvState>(
        builder: (context, state) {
          if (state is TvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeasonDetailSuccess) {
            final tvRecommendations =
                context.select<TvRecommendationBloc, List<TvShow>>((value) {
              final recommendationState = value.state;
              return recommendationState is TvSuccess
                  ? recommendationState.tvList
                  : [];
            });
            final isAddedToWatchlist =
                context.select<TvWatchlistBloc, bool>((TvWatchlistBloc value) {
              final state = value.state;
              return state is TvWatchlistStatus ? state.status : false;
            });
            return SafeArea(
              child: DetailSeasonContent(
                tv: widget.tv,
                season: state.tvSeason,
                recommendations: tvRecommendations,
                isAddedWatchlist: isAddedToWatchlist,
              ),
            );
          } else if (state is TvError) {
            return Text(
              state.message,
              key: const Key('error_message'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailSeasonContent extends StatelessWidget {
  final TvDetail tv;
  final SeasonDetail season;
  final List<TvShow> recommendations;
  final bool isAddedWatchlist;

  const DetailSeasonContent({
    super.key,
    required this.tv,
    required this.season,
    required this.recommendations,
    required this.isAddedWatchlist,
  });

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        season.posterPath == null
            ? Image.asset('assets/circle-g.png')
            : CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
                width: sizeWidth,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            minChildSize: 0.25,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.0)),
                ),
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              season.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<TvWatchlistBloc>()
                                      .add(SaveTvWatchlist(tv));
                                } else {
                                  context
                                      .read<TvWatchlistBloc>()
                                      .add(RemoveTvWatchlist(tv));
                                }

                                String message = !isAddedWatchlist
                                    ? TvWatchlistBloc.watchlistAddSuccessMessage
                                    : TvWatchlistBloc
                                        .watchlistRemoveSuccessMessage;

                                final state =
                                    BlocProvider.of<TvWatchlistBloc>(context)
                                        .state;
                                if (state is WatchlistTvMessage ||
                                    state is TvWatchlistStatus) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(content: Text(message)),
                                  );
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text(' Watchlist'),
                                ],
                              ),
                            ),
                            Text(_showGenres(tv.genres)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                  itemCount: 5,
                                  rating: tv.voteAverage / 2,
                                ),
                                Text('${tv.voteAverage}'),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(season.overview == '' ? '-' : season.overview),
                            const SizedBox(height: 4),
                            const Divider(
                              color: Colors.white24,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '${season.episodes.length} Episodes',
                              style: kHeading6,
                            ),
                            const SizedBox(height: 8),
                            season.episodes.isEmpty
                                ? const Text('-')
                                : SizedBox(
                                    key: const Key('season-tv-test'),
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: season.episodes.length,
                                      itemBuilder: (context, index) {
                                        final eps = season.episodes[index];

                                        return IntrinsicWidth(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(18.0),
                                                    ),
                                                    child: eps.stillPath == null
                                                        ? Image.asset(
                                                            'assets/circle-g.png',
                                                            width: 100,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  'https://image.tmdb.org/t/p/w500${eps.stillPath}',
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                            ),
                                                          ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(18),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          18)),
                                                      color: Colors.white70,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            'Episode ${eps.episodeNumber.toString()}',
                                                            style: kHeading6.copyWith(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            eps.name,
                                                            style: kHeading6
                                                                .copyWith(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            const SizedBox(height: 16),
                            Text(
                              '${tv.seasons.length} Seasons',
                              style: kHeading6,
                            ),
                            const SizedBox(height: 8),
                            tv.seasons.isEmpty
                                ? const Text('-')
                                : SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tv.seasons.length,
                                      itemBuilder: (context, index) {
                                        final tvs = tv.seasons[index];

                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () =>
                                                Navigator.pushReplacementNamed(
                                              context,
                                              TvSeasonDetailPage.ROUTE_NAME,
                                              arguments: {
                                                'tvId': tv,
                                                'seasonNumber':
                                                    tvs.seasonNumber,
                                              },
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                              child: tvs.posterPath == null
                                                  ? Image.asset(
                                                      'assets/circle-g.png',
                                                      width: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : CachedNetworkImage(
                                                      imageUrl:
                                                          'https://image.tmdb.org/t/p/w500${tvs.posterPath}',
                                                      placeholder:
                                                          (context, url) =>
                                                              const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            const SizedBox(height: 8),
                            BlocBuilder<TvRecommendationBloc, TvState>(
                              builder: (context, state) {
                                if (state is TvLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvError) {
                                  return Text(
                                    state.message,
                                    key: const Key('error_message'),
                                  );
                                } else if (state is TvSuccess) {
                                  return SizedBox(
                                    key: const Key('recommendation-tv-test'),
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: recommendations.length,
                                      itemBuilder: (context, index) {
                                        final tv = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () =>
                                                Navigator.pushReplacementNamed(
                                              context,
                                              TvDetailPage.ROUTE_NAME,
                                              arguments: tv.id,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
