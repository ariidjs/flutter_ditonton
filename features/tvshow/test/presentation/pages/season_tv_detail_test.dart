import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../dummy_data/tv_dummy_object.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';
import 'package:tvshow/presentation/pages/tv_season_detail_page.dart';

class TvEventFake extends Fake implements TvEvent {}

class TvStateFake extends Fake implements TvState {}

class MockTvSeasonDetailBloc extends MockBloc<TvEvent, TvState>
    implements TvSeasonDetailBloc {}

class MockTvRecommendationsBloc extends MockBloc<TvEvent, TvState>
    implements TvRecommendationBloc {}

class MockTvWatchlistBloc extends MockBloc<TvEvent, TvState>
    implements TvWatchlistBloc {}

void main() {
  late MockTvSeasonDetailBloc mockTvSeasonDetailBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  setUp(() {
    mockTvSeasonDetailBloc = MockTvSeasonDetailBloc();
    mockTvRecommendationsBloc = MockTvRecommendationsBloc();
    mockTvWatchlistBloc = MockTvWatchlistBloc();
    registerFallbackValue(TvEventFake());
    registerFallbackValue(TvStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeasonDetailBloc>(create: (_) => mockTvSeasonDetailBloc),
        BlocProvider<TvWatchlistBloc>(create: (context) => mockTvWatchlistBloc),
        BlocProvider<TvRecommendationBloc>(
            create: (context) => mockTvRecommendationsBloc),
      ],
      child: MaterialApp(home: body),
    );
  }

  group('detail test', () {
    testWidgets('content of Season Details and recommendation should display',
        (WidgetTester tester) async {
      when(() => mockTvSeasonDetailBloc.state)
          .thenReturn(TvSeasonDetailSuccess(testTvSeasonDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvSuccess(testTvList));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(TvWatchlistStatus(false));

      await tester.pumpWidget(_makeTestableWidget(
          TvSeasonDetailPage(tv: testTvDetail, seasonNumber: 1)));

      expect(find.byKey(Key('season-tv-test')), findsOneWidget);
      expect(find.byKey(Key('recommendation-tv-test')), findsOneWidget);
    });

    testWidgets('should display text with message when Error getting detail',
        (WidgetTester tester) async {
      when(() => mockTvSeasonDetailBloc.state)
          .thenReturn(TvError('Error message'));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
        tv: testTvDetail,
        seasonNumber: 1,
      )));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('should display center progress bar when loading detail',
        (WidgetTester tester) async {
      when(() => mockTvSeasonDetailBloc.state).thenReturn(TvLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
        tv: testTvDetail,
        seasonNumber: 1,
      )));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets(
        'should display text with message when Error getting recommendations',
        (WidgetTester tester) async {
      when(() => mockTvSeasonDetailBloc.state)
          .thenReturn(TvSeasonDetailSuccess(testTvSeasonDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvError('Error message'));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(TvWatchlistStatus(false));
      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
        tv: testTvDetail,
        seasonNumber: 1,
      )));

      expect(textFinder, findsOneWidget);
    });

    testWidgets(
        'should display center progress bar when loading recommendations',
        (WidgetTester tester) async {
      when(() => mockTvSeasonDetailBloc.state)
          .thenReturn(TvSeasonDetailSuccess(testTvSeasonDetail));
      when(() => mockTvRecommendationsBloc.state).thenReturn(TvLoading());
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(TvWatchlistStatus(false));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
        tv: testTvDetail,
        seasonNumber: 1,
      )));

      expect(centerFinder, findsWidgets);
      expect(progressBarFinder, findsWidgets);
    });
  });

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvSeasonDetailBloc.state)
        .thenReturn(TvSeasonDetailSuccess(testTvSeasonDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvSuccess(testTvList));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      tv: testTvDetail,
      seasonNumber: 1,
    )));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvSeasonDetailBloc.state)
        .thenReturn(TvSeasonDetailSuccess(testTvSeasonDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvSuccess(testTvList));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      tv: testTvDetail,
      seasonNumber: 1,
    )));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvSeasonDetailBloc.state)
        .thenReturn(TvSeasonDetailSuccess(testTvSeasonDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvSuccess(testTvList));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(false));
    when(() => mockTvWatchlistBloc.state).thenReturn(
        WatchlistTvMessage(TvWatchlistBloc.watchlistAddSuccessMessage));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      tv: testTvDetail,
      seasonNumber: 1,
    )));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(
        find.text(TvWatchlistBloc.watchlistAddSuccessMessage), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(() => mockTvSeasonDetailBloc.state)
        .thenReturn(TvSeasonDetailSuccess(testTvSeasonDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvSuccess(testTvList));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(true));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      tv: testTvDetail,
      seasonNumber: 1,
    )));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(TvWatchlistBloc.watchlistRemoveSuccessMessage),
        findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockTvSeasonDetailBloc.state)
        .thenReturn(TvSeasonDetailSuccess(testTvSeasonDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvSuccess(testTvList));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(false));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvError('Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      tv: testTvDetail,
      seasonNumber: 1,
    )));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
