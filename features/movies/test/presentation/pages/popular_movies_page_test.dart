import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../dummy_data/dummy_objects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/bloc/movie_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';

class MovieEventFake extends Fake implements MovieEvent {}

class MovieStateFake extends Fake implements MovieState {}

class MockPopularMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements PopularMovieBloc {}

void main() {
  late MockPopularMovieBloc mockPopularMovieBloc;
  setUp(() {
    mockPopularMovieBloc = MockPopularMovieBloc();
    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (_) => mockPopularMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state).thenReturn(MovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state)
        .thenReturn(MovieSuccess(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state)
        .thenReturn(MovieError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
