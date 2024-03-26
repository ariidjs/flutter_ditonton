import 'search_tv_page.dart';
import 'tv_detail_page.dart';
import 'popular_tv_page.dart';
import 'top_rated_tv_page.dart';
import 'watchlist_tv_page.dart';
import 'on_the_air_tv_page.dart';
import '../../../../features/movies/lib/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import '../movies/home_movie_page.dart';
import 'package:provider/provider.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/state_enum.dart';
import '../movies/watchlist_movies_page.dart';
import '../../provider/tv/tv_list_notifier.dart';
import 'package:core/domain/entities/tv/tv_show.dart';
import 'package:cached_network_image/cached_network_image.dart';


class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_show';
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  State<HomeTvPage> createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TvListNotifier>(context, listen: false)
        ..fetchOnTheAirTvShows()
        ..fetchPopularTvShows()
        ..fetchTopRatedTvShows(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () =>
                  Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME),
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () =>
                  Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV Shows'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist TV Shows'),
              onTap: () =>
                  Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About'),
              onTap: () => Navigator.pushNamed(context, AboutPage.ROUTE_NAME),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME),
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'On The Air',
                key: Key('on_the_air'),
                onTap: () =>
                    Navigator.pushNamed(context, OnTheAirTvPage.ROUTE_NAME),
              ),
              Consumer<TvListNotifier>(
                builder: (context, data, child) {
                  final state = data.onTheAirTvState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvList(data.onTheAirTvShows);
                  } else {
                    return Text(data.message);
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular TV Shows',
                key: Key('popular'),
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              Consumer<TvListNotifier>(
                builder: (context, data, child) {
                  final state = data.popularTvState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvList(data.popularTvShows);
                  } else {
                    return Text(data.message);
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated TV Shows',
                key: Key('top_rated'),
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              Consumer<TvListNotifier>(
                builder: (context, data, child) {
                  final state = data.topRatedState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvList(data.topRatedTvShows);
                  } else {
                    return Text(data.message);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading(
      {required String title, required Function() onTap, required Key key}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<TvShow> tvs;

  TvList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tvs.length,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            key: Key('item_at_$index'),
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                TvDetailPage.ROUTE_NAME,
                arguments: tv.id,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
