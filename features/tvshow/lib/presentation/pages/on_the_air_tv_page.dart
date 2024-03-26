import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';
import 'package:tvshow/presentation/widgets/tv_card_list.dart';


class OnTheAirTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/on_air_tv';

  const OnTheAirTvPage({super.key});

  @override
  State<OnTheAirTvPage> createState() => _OnTheAirTVPageState();
}

class _OnTheAirTVPageState extends State<OnTheAirTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<OnTheAirTvBloc>().add(OnTheAir()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTvBloc, TvState>(
          builder: (context, state) {
            if (state is TvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.tvList[index];
                  return TvCard(movie);
                },
                itemCount: state.tvList.length,
              );
            } else if (state is TvError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
