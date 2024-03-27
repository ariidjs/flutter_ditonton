import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../dummy_data/tv/tv_dummy_object.dart';



// @GenerateMocks([TvSeasonDetailNotifier])
void main() {
  // late MockTvSeasonDetailNotifier mockNotifier;

  // setUp(() {
  //   mockNotifier = MockTvSeasonDetailNotifier();
  // });

  // Widget _makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<TvSeasonDetailNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(home: body),
  //   );
  // }

  // group('detail test', () {
  //   testWidgets('content of Season Details and recommendation should display',
  //       (WidgetTester tester) async {
  //     when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
  //     when(mockNotifier.seasonDetail).thenReturn(testTvSeasonDetail);
  //     when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //     when(mockNotifier.tvRecommendations).thenReturn(<TvShow>[testTv]);
  //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);

  //     await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
  //       tv: testTvDetail,
  //       seasonNumber: 1,
  //     )));

  //     expect(find.byKey(Key('season-tv-test')), findsOneWidget);
  //     expect(find.byKey(Key('recommendation-tv-test')), findsOneWidget);
  //   });

  //   testWidgets('should display text with message when Error getting detail',
  //       (WidgetTester tester) async {
  //     when(mockNotifier.seasonState).thenReturn(RequestState.Error);
  //     when(mockNotifier.seasonDetail).thenReturn(testTvSeasonDetail);
  //     when(mockNotifier.message).thenReturn('Error message');
  //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);

  //     final textFinder = find.byKey(Key('error_message'));

  //     await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
  //       tv: testTvDetail,
  //       seasonNumber: 1,
  //     )));

  //     expect(textFinder, findsOneWidget);
  //   });

  //   testWidgets('should display center progress bar when loading detail',
  //       (WidgetTester tester) async {
  //     when(mockNotifier.seasonState).thenReturn(RequestState.Loading);
  //     when(mockNotifier.seasonDetail).thenReturn(testTvSeasonDetail);

  //     final progressBarFinder = find.byType(CircularProgressIndicator);
  //     final centerFinder = find.byType(Center);

  //     await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
  //       tv: testTvDetail,
  //       seasonNumber: 1,
  //     )));

  //     expect(centerFinder, findsOneWidget);
  //     expect(progressBarFinder, findsOneWidget);
  //   });

  //   testWidgets(
  //       'should display text with message when Error getting recommendations',
  //       (WidgetTester tester) async {
  //     when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
  //     when(mockNotifier.seasonDetail).thenReturn(testTvSeasonDetail);
  //     when(mockNotifier.recommendationState).thenReturn(RequestState.Error);
  //     when(mockNotifier.tvRecommendations).thenReturn(<TvShow>[testTv]);
  //     when(mockNotifier.message).thenReturn('Error message');
  //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);

  //     final textFinder = find.byKey(Key('error_message'));

  //     await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
  //       tv: testTvDetail,
  //       seasonNumber: 1,
  //     )));

  //     expect(textFinder, findsOneWidget);
  //   });

  //   testWidgets(
  //       'should display center progress bar when loading recommendations',
  //       (WidgetTester tester) async {
  //     when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
  //     when(mockNotifier.seasonDetail).thenReturn(testTvSeasonDetail);
  //     when(mockNotifier.recommendationState).thenReturn(RequestState.Loading);
  //     when(mockNotifier.tvRecommendations).thenReturn(<TvShow>[]);
  //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);

  //     final progressBarFinder = find.byType(CircularProgressIndicator);
  //     final centerFinder = find.byType(Center);

  //     await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
  //       tv: testTvDetail,
  //       seasonNumber: 1,
  //     )));

  //     expect(centerFinder, findsWidgets);
  //     expect(progressBarFinder, findsWidgets);
  //   });
  // });

  // testWidgets(
  //     'Watchlist button should display add icon when tv not added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.seasonDetail).thenReturn(testTvSeasonDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.tvRecommendations).thenReturn(<TvShow>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);

  //   final watchlistButtonIcon = find.byIcon(Icons.add);

  //   await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
  //     tv: testTvDetail,
  //     seasonNumber: 1,
  //   )));

  //   expect(watchlistButtonIcon, findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should dispay check icon when tv is added to wathclist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.seasonDetail).thenReturn(testTvSeasonDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.tvRecommendations).thenReturn(<TvShow>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(true);

  //   final watchlistButtonIcon = find.byIcon(Icons.check);

  //   await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
  //     tv: testTvDetail,
  //     seasonNumber: 1,
  //   )));

  //   expect(watchlistButtonIcon, findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.seasonDetail).thenReturn(testTvSeasonDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.tvRecommendations).thenReturn(<TvShow>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
  //     tv: testTvDetail,
  //     seasonNumber: 1,
  //   )));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(SnackBar), findsOneWidget);
  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.seasonDetail).thenReturn(testTvSeasonDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.tvRecommendations).thenReturn(<TvShow>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Failed');

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
  //     tv: testTvDetail,
  //     seasonNumber: 1,
  //   )));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
