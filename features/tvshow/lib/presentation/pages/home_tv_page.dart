import 'search_tv_page.dart';
import 'tv_detail_page.dart';
import 'popular_tv_page.dart';
import 'top_rated_tv_page.dart';
import 'on_the_air_tv_page.dart';
import 'package:movies/movies.dart';
import 'package:flutter/material.dart';
import 'package:core/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/domain/entities/tv_show.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tvshow/presentation/pages/watchlist_tv_page.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_show';
  const HomeTvPage({super.key});

  @override
  State<HomeTvPage> createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OnTheAirTvBloc>().add(OnTheAir());
      context.read<PopularTvBloc>().add(PopularTv());
      context.read<TopRatedTvBloc>().add(TopRatedTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () =>
                  Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME),
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () =>
                  Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV Shows'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist TV Shows'),
              onTap: () =>
                  Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About'),
              // onTap: () => Navigator.pushNamed(context, AboutPage.ROUTE_NAME),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME),
            icon: const Icon(Icons.search),
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
                key: const Key('on_the_air'),
                onTap: () =>
                    Navigator.pushNamed(context, OnTheAirTvPage.ROUTE_NAME),
              ),
              BlocBuilder<OnTheAirTvBloc, TvState>(builder: (context, state) {
                if (state is TvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSuccess) {
                  return TvList(state.tvList);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular TV Shows',
                key: const Key('popular'),
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvBloc, TvState>(builder: (context, state) {
                if (state is TvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSuccess) {
                  return TvList(state.tvList);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated TV Shows',
                key: const Key('top_rated'),
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvBloc, TvState>(builder: (context, state) {
                if (state is TvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSuccess) {
                  return TvList(state.tvList);
                } else {
                  return const Text('Failed');
                }
              }),
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
            padding: EdgeInsets.all(8.0),
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

  const TvList(this.tvs, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
