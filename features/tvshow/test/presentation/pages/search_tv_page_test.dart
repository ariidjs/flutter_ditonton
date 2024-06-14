import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../dummy_data/tv_dummy_object.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshow/presentation/bloc/tv_bloc.dart';
import 'package:tvshow/presentation/pages/search_tv_page.dart';
import 'package:tvshow/presentation/widgets/tv_card_list.dart';

class TvEventFake extends Fake implements TvEvent {}

class TvStateFake extends Fake implements TvState {}

class MockSearchTvBloc extends MockBloc<TvEvent, TvState>
    implements SearchTvBloc {}

void main() {
  late MockSearchTvBloc mockSearchTvBloc;

  setUp(() {
    mockSearchTvBloc = MockSearchTvBloc();
    registerFallbackValue(TvEventFake());
    registerFallbackValue(TvStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvBloc>(
      create: (_) => mockSearchTvBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('textfield test', (WidgetTester tester) async {
    String query = 'test-search';
    when(() => mockSearchTvBloc.state).thenReturn(TvEmpty());
    await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));

    await tester.enterText(find.byKey(Key('textfield-test')), query);
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    expect(find.text(query), findsOneWidget);
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state).thenReturn(TvLoading());

    await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state).thenReturn(TvSuccess(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));

    expect(listViewFinder, findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('Page should display Text when data is empty',
      (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state).thenReturn(TvSuccess([]));

    final textViewFinder = find.byKey(Key('search-test'));

    await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));

    expect(textViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state).thenReturn(TvError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
