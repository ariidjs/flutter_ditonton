import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/tv_card_list.dart';
import 'package:core/common/state_enum.dart';
import '../../provider/tv/popular_tv_notifier.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular_tv';

  const PopularTvPage({Key? key}) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTVPageState();
}

class _PopularTVPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTvNotifier>(context, listen: false)
            .fetchPopularTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvNotifier>(
          builder: (context, data, child) {
            final state = data.state;
            if (state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvShows[index];
                  return TvCard(tv);
                },
                itemCount: data.tvShows.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
