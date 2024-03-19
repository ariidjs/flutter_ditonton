import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movies/genre.dart';
import 'package:ditonton/domain/entities/tv/season_detail.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_season_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvSeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/season_detail_tv';
  final int tvId;
  final int seasonNumber;

  const TvSeasonDetailPage({
    required this.tvId,
    required this.seasonNumber,
  });

  @override
  State<TvSeasonDetailPage> createState() => _TVSeasonDetailPageState();
}

class _TVSeasonDetailPageState extends State<TvSeasonDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await Provider.of<TvSeasonDetailNotifier>(context, listen: false)
          .fetchSeasonDetail(widget.tvId, widget.seasonNumber);
      await Provider.of<TvSeasonDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.tvId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeasonDetailNotifier>(
        builder: (context, provider, child) {
          final state = provider.seasonState;

          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return SafeArea(
              child: DetailSeasonContent(
                tv: provider.tvDetail,
                season: provider.seasonDetail,
                recommendations: provider.tvRecommendations,
                isAddedWatchlist: provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
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
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            minChildSize: 0.25,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
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
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  await Provider.of<TvSeasonDetailNotifier>(
                                          context,
                                          listen: false)
                                      .addWatchlist(tv);
                                } else {
                                  await Provider.of<TvSeasonDetailNotifier>(
                                          context,
                                          listen: false)
                                      .removeFromWatchlist(tv);
                                }

                                final message =
                                    Provider.of<TvSeasonDetailNotifier>(context,
                                            listen: false)
                                        .watchlistMessage;

                                if (message ==
                                        TvSeasonDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        TvSeasonDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
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
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text(' Watchlist'),
                                ],
                              ),
                            ),
                            Text(_showGenres(tv.genres)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  itemBuilder: (context, index) => Icon(
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
                            SizedBox(height: 12),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(tv.overview == '' ? '-' : tv.overview),
                            SizedBox(height: 4),
                            Divider(
                              color: Colors.white24,
                            ),
                            Text(
                              'Season: ${season.name}',
                              style: kHeading6,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview Season',
                              style: kHeading6,
                            ),
                            Text(
                              season.overview == '' ? '-' : season.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              '${season.episodes.length} Episodes',
                              style: kHeading6,
                            ),
                            SizedBox(height: 8),
                            season.episodes.length == 0
                                ? Text('-')
                                : Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: season.episodes.length,
                                      itemBuilder: (context, index) {
                                        final eps = season.episodes[index];

                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {},
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(18.0),
                                                  ),
                                                  child: eps.stillPath == null
                                                      ? Image.asset(
                                                          'assets/circle-g.png',
                                                          width: 100,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : CachedNetworkImage(
                                                          imageUrl:
                                                              'https://image.tmdb.org/t/p/w500${eps.stillPath}',
                                                          placeholder:
                                                              (context, url) =>
                                                                  Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                ),
                                                Positioned(
                                                  bottom: 10,
                                                  right: 10,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 6,
                                                      horizontal: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                      color: Colors.white70,
                                                    ),
                                                    child: Text(
                                                      'Episode ${eps.episodeNumber.toString()}',
                                                      style: kHeading6.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            SizedBox(height: 16),
                            Text(
                              '${tv.seasons.length} Seasons',
                              style: kHeading6,
                            ),
                            SizedBox(height: 8),
                            tv.seasons.length == 0
                                ? Text('-')
                                : Container(
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
                                                'tvId': tv.id,
                                                'seasonNumber':
                                                    tvs.seasonNumber,
                                              },
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
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
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            SizedBox(height: 8),
                            recommendations.length == 0
                                ? Text('-')
                                : Consumer<TvSeasonDetailNotifier>(
                                    builder: (context, data, child) {
                                      final state = data.recommendationState;
                                      if (state == RequestState.Loading) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (state == RequestState.Error) {
                                        return Text(data.message);
                                      } else if (state == RequestState.Loaded) {
                                        return Container(
                                          height: 150,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: recommendations.length,
                                            itemBuilder: (context, index) {
                                              final tv = recommendations[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: InkWell(
                                                  onTap: () => Navigator
                                                      .pushReplacementNamed(
                                                    context,
                                                    TvDetailPage.ROUTE_NAME,
                                                    arguments: tv.id,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8.0),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                      placeholder:
                                                          (context, url) =>
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
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
              icon: Icon(Icons.arrow_back),
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
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}