import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../dummy_data/tv/tv_dummy_object.dart';
import '../../../../features/tvshow/lib/presentation/widgets/tv_card_list.dart';



// @GenerateMocks([PopularTvNotifier])
void main() {
  // late MockPopularTvNotifier mockNotifier;

  // setUp(() {
  //   mockNotifier = MockPopularTvNotifier();
  // });

  // Widget _makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<PopularTvNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }

  // testWidgets('Page should display center progress bar when loading',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Loading);

  //   final progressBarFinder = find.byType(CircularProgressIndicator);
  //   final centerFinder = find.byType(Center);

  //   await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

  //   expect(centerFinder, findsOneWidget);
  //   expect(progressBarFinder, findsOneWidget);
  // });

  // testWidgets('Page should display ListView when data is loaded',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.tvShows).thenReturn(<TvShow>[testTv]);

  //   final listViewFinder = find.byType(ListView);

  //   await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

  //   expect(listViewFinder, findsOneWidget);
  //   expect(find.byType(TvCard), findsOneWidget);
  // });

  // testWidgets('Page should display text with message when Error',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Error);
  //   when(mockNotifier.message).thenReturn('Error message');

  //   final textFinder = find.byKey(Key('error_message'));

  //   await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

  //   expect(textFinder, findsOneWidget);
  // });
}
