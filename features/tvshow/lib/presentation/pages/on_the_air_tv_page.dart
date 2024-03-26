import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/tv_card_list.dart';
import 'package:core/common/state_enum.dart';
import '../../provider/tv/on_the_air_tv_notifier.dart';

class OnTheAirTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/on_air_tv';

  const OnTheAirTvPage({Key? key}) : super(key: key);

  @override
  State<OnTheAirTvPage> createState() => _OnTheAirTVPageState();
}

class _OnTheAirTVPageState extends State<OnTheAirTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnTheAirTvNotifier>(context, listen: false)
            .fetchOnTheAirTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnTheAirTvNotifier>(
          builder: (context, data, child) {
            final state = data.state;
            if (state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.Loaded) {
              return ListView.builder(
                itemCount: data.tv.length,
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TvCard(tv);
                },
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
