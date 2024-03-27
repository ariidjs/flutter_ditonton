import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../dummy_data/dummy_objects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/pages/pages.dart';
import 'package:movies/presentation/bloc/movie_bloc.dart';

class MovieEventFake extends Fake implements MovieEvent {}

class MovieStateFake extends Fake implements MovieState {}

class MockMovieDetailBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieDetailBloc {}

class MockMovieRecommendationsBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieRecommentaionsBloc {}

class MockMovieWatchlistBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieWatchlistBloc {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationsBloc mockMovieRecommendationsBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationsBloc = MockMovieRecommendationsBloc();
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<MovieRecommentaionsBloc>(
          create: (context) => mockMovieRecommendationsBloc,
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (context) => mockMovieWatchlistBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('detail test', () {
    testWidgets('content of Movie Details and recommendation should display',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailSuccess(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(MovieSuccess(testMovieList));
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistStatus(false));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(find.byKey(Key('recommendation-test')), findsOneWidget);
    });

    testWidgets('should display text with message when Error getting detail',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieError('Error message'));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('should display center progress bar when loading detail',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets(
        'should display text with message when Error getting recommendations',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailSuccess(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(MovieError('Error message'));
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistStatus(false));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(textFinder, findsWidgets);
    });

    testWidgets(
        'should display center progress bar when loading recommendations',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailSuccess(testMovieDetail));
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistStatus(false));
      when(() => mockMovieRecommendationsBloc.state).thenReturn(MovieLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(centerFinder, findsWidgets);
      expect(progressBarFinder, findsWidgets);
    });
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailSuccess(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieSuccess(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieWatchlistStatus(false));
    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailSuccess(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieSuccess(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieWatchlistStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailSuccess(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieSuccess(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieWatchlistStatus(false));
    when(() => mockMovieWatchlistBloc.state).thenReturn(
        WatchlistMovieMessage(MovieWatchlistBloc.watchlistAddSuccessMessage));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(MovieWatchlistBloc.watchlistAddSuccessMessage),
        findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailSuccess(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieSuccess(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieWatchlistStatus(false));
    when(() => mockMovieWatchlistBloc.state).thenReturn(MovieError('Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
