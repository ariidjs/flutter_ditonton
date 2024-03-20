import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_season_detail_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_season_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/tv/tv_dummy_object.dart';
import 'season_tv_detail_test.mocks.dart';

@GenerateMocks([TvSeasonDetailNotifier])
void main() {
  late MockTvSeasonDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeasonDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MockTvSeasonDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(home: body),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvDetail).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      tvId: 1,
      seasonNumber: 1,
    )));
    final watchlistButtonIcon = find.byIcon(Icons.add);

    expect(watchlistButtonIcon, Icons.add);

    // expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvDetail).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      tvId: 1,
      seasonNumber: 1,
    )));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvDetail).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      tvId: 1,
      seasonNumber: 1,
    )));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvDetail).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      tvId: 1,
      seasonNumber: 1,
    )));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
