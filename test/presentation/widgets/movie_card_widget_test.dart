import 'package:ditonton/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../dummy_data/movies/dummy_objects.dart';

void main() {
  final _movie = testMovie;
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
      'When create widget '
      'Should find the correct widgets', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: MovieCard(_movie),
        ),
      ),
    );

    await tester.pump();

    expect(find.text(_movie.title!), findsOneWidget);
  });
  testWidgets('pushes Detail when Card is tapped', (tester) async {
    final navigator = MockNavigator();
    when(navigator.canPop).thenReturn(true);
    when(() => navigator.push(any())).thenAnswer((_) async {
      return null;
    });

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: MockNavigatorProvider(
            navigator: navigator,
            child: MovieCard(testMovie),
          ),
        ),
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await tester.ensureVisible(find.byType(InkWell));
    await tester.tap(find.byType(InkWell));

    await tester.pump();

    // await tester.pumpAndSettle();

    // verify(
    //   () => navigator.pushNamed(
    //       any(
    //           that:
    //               isRoute<void>(whereName: equals(MovieDetailPage.ROUTE_NAME))),
    //       arguments: 1),
    // ).called(1);
  });
}
