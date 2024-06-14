import 'package:flutter/material.dart';
import 'package:core/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';
import 'package:tvshow/presentation/widgets/tv_card_list.dart';

class SearchTvPage extends StatelessWidget {
  static const ROUTE_NAME = '/search_tv';

  const SearchTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) =>
                  context.read<SearchTvBloc>().add(SearchTvQuery(query)),
              onChanged: (query) =>
                  context.read<SearchTvBloc>().add(SearchTvQuery(query)),
              decoration: const InputDecoration(
                hintText: 'Search name of tv show',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
              key: Key('textfield-test'),
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTvBloc, TvState>(
              builder: (context, state) {
                if (state is TvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSuccess) {
                  if (state.tvList.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              key: Key('search-test'),
                              'TV Show not found',
                              style: kHeading6.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        final tv = state.tvList[index];
                        return TvCard(tv);
                      },
                      itemCount: state.tvList.length,
                    ),
                  );
                } else if (state is TvError) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                }
                return Expanded(
                  child: Container(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
